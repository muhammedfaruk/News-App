//
//  UITabBarVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 31.12.2021.
//

import UIKit

class UITabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemRed
        viewControllers                 = [createNewsNC(),createSearcNewsNC(),createVideosNC()]
    }

    func createNewsNC() -> UINavigationController {
        let newsListVC = MainContainerVC()
        newsListVC.tabBarItem   = UITabBarItem(title: "Haberler", image: UIImage(systemName: "newspaper"), tag: 0)
        
        return UINavigationController(rootViewController: newsListVC)
    }
    
    
    func createSearcNewsNC() -> UINavigationController {
        let searchNewsVC    = SearchNewsVC(searchText: "")
        searchNewsVC.title  = "Haber Ara"
        searchNewsVC.tabBarItem = UITabBarItem(title: "Haber Ara", image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
        
        return UINavigationController(rootViewController: searchNewsVC)
    }
    
    
    func createVideosNC() -> UINavigationController {
        let videoVC = WriterVC()
        videoVC.title       = "Haber Yazarları"
        videoVC.tabBarItem  = UITabBarItem(title: "Yazarlar", image: UIImage(systemName: "person.3"), tag: 2)
        
        return UINavigationController(rootViewController: videoVC)
    }
    
    

}

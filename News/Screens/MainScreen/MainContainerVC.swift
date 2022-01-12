//
//  ContainerVC.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 12.01.2022.
//

import UIKit

class MainContainerVC: UIViewController {
    
    enum menu_State {
        case opened
        case closed
    }
    
    private var menuState:menu_State = .closed // default
    
    let sideMenu = SideMenu()
    let newsMenu = NewsListVC()
    
    var navigationVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addchildVC()
    }
    
    
    private func addchildVC(){
        addChild(sideMenu)
        view.addSubview(sideMenu.view)
        sideMenu.didMove(toParent: self)
        sideMenu.delegate = self
        
        newsMenu.delegate = self
        let menuSideVC      = UINavigationController(rootViewController: newsMenu)
        addChild(menuSideVC)
        view.addSubview(menuSideVC.view)
        menuSideVC.didMove(toParent: self)
        self.navigationVC = menuSideVC
    }
    
}

extension MainContainerVC: NewsListVCDelegate {
    
    func didTapSlideButton() {
        toggleMenu()
    }
    
    func toggleMenu(){
        switch menuState {
        case .closed:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navigationVC?.view.frame.origin.x = self.sideMenu.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                
                if done {
                    self?.menuState = .opened
                }
                
            }
            
        case .opened:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navigationVC?.view.frame.origin.x = 0
                
            } completion: { [weak self]done in
                
                if done {
                    self?.menuState = .closed
                }
            }
        }
    }
}

extension MainContainerVC: SideMenuDelegate{
    
    func didTapSideContent(menuItem: MenuContent) {
        
        toggleMenu()
        let newsSearchVC = SearchNewsVC(searchText: menuItem.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "News")
        
        navigationController?.pushViewController(newsSearchVC, animated: true)
    }
    
}


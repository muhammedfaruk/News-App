//
//  NewsContentVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 26.12.2021.
//

import UIKit
import SafariServices

class NewsContentVC: UIViewController {
    
    let contentView    = UIView()
    var news : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureVC()
        configureUIElement()
    }

    
    init(news: Article) {
        super.init(nibName: nil, bundle: nil)
        self.news = news
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureVC(){
        view.backgroundColor        = .systemBackground       
        
        let detailsButton = UIBarButtonItem(title: "Ayrıntıya Git", style: .done, target: self, action: #selector(goDetailWithSafari))       
        navigationItem.rightBarButtonItem = detailsButton
    }
    
    
    @objc func goDetailWithSafari(){

        guard let url = URL(string: news.url) else {return}

        let safari = SFSafariViewController(url: url)
        safari.preferredControlTintColor = .red
        present(safari, animated: true)
   
    }
    
    
    func configureUIElement(){
        
        view.addSubview(contentView)
        contentView.pinToEdges(subView: view)
        
        DispatchQueue.main.async {
            self.add(childVC: NewsDetailVC(news: self.news), containerView: self.contentView)
        }
    }
    
 
    func add(childVC : UIViewController, containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

}

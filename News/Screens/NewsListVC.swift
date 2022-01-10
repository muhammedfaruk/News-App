//
//  NewsListVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 19.12.2021.
//

import UIKit

class NewsListVC: UIViewController{
    
    let mainContainerView       = UIView()
    let mainScroolView          = UIScrollView()
    let swipeContainerView      = UIView()
    let pageControl             = UIPageControl()
    let tableView               = UITableView()

    var newsArray: [Article]    = []
    let changeSwipePageName     = Notification.Name("change")
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getNews()
        createObserver()
        configureSwipeView()
        configurePageControl()
        configureTableView()
        configureScroolView()
        configureContainerView()
    }
            
    
    func configureScroolView(){
        view.addSubview(mainScroolView)
        mainScroolView.delegate = self
        mainScroolView.pinToEdges(subView: view)
    }
    
    
    func configureContainerView(){
        mainScroolView.addSubview(mainContainerView)
        mainContainerView.pinToEdges(subView: mainScroolView)
        
        let tableViewRowHeight  = Double(tableView.rowHeight)
        let numberOfRows        = 20.0
        
        NSLayoutConstraint.activate([
            mainContainerView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfRows * tableViewRowHeight)),
            mainContainerView.widthAnchor.constraint(equalTo: mainScroolView.widthAnchor)
        ])
    }
    
    
    func createObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(changeCurrentPage), name: changeSwipePageName, object: nil)
    }
    
     
    @objc func changeCurrentPage(notification: NSNotification){
        guard let currentPage = notification.userInfo?["currentPageValue"] as? Int else {return}
        pageControl.currentPage = currentPage
    }
    
     
    func configureSwipeView(){
        
        mainContainerView.addSubview(swipeContainerView)
        swipeContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swipeContainerView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            swipeContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 8),
            swipeContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -8),
            swipeContainerView.widthAnchor.constraint(equalTo: swipeContainerView.heightAnchor, multiplier: 1.8)
        ])
        
        DispatchQueue.main.async {
            let swipingCV =  SwipingCollectionView(collectionViewLayout: UICollectionViewLayout())
            self.add(childVC: swipingCV, containerView: self.swipeContainerView)
        }
           
    }
    
    
    func add(childVC : UICollectionViewController, containerView: UIView){
           addChild(childVC)
           containerView.addSubview(childVC.view)
           childVC.view.frame = containerView.bounds
           childVC.didMove(toParent: self)
    }
    
    
    func configurePageControl(){
        
        pageControl.currentPage                     = 0
        pageControl.numberOfPages                   = 5
        pageControl.pageIndicatorTintColor          = .gray
        pageControl.currentPageIndicatorTintColor   = .red
        pageControl.allowsContinuousInteraction     = false
        pageControl.isUserInteractionEnabled        = false
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
           
        mainContainerView.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: swipeContainerView.bottomAnchor, constant: 5),
            pageControl.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 20),
            pageControl.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
              
    func configureTableView(){
       
        mainContainerView.addSubview(tableView)
        
        tableView.rowHeight = 120
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 12),
            tableView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor)
        ])
    }
    
 
    func getNews(){
        NetworkManager.shared.downloadNewsData {[weak self] result in
            guard let self = self else {return}
                        
            switch result {
             case .success(let news):
                self.newsArray = news.articles
                
             case.failure(let error):
                print(error.rawValue)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
         }
       }
     }



extension NewsListVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell        = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsTableViewCell
        let newsArticle = newsArray[indexPath.row]
        cell.set(article: newsArticle)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsArticle = newsArray[indexPath.row]
        let contentVC   = NewsContentVC(news: newsArticle)
        
        navigationController?.pushViewController(contentVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
}




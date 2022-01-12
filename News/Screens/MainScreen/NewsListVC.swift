//
//  NewsListVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 19.12.2021.
//

import UIKit

protocol NewsListVCDelegate: AnyObject{
    func didTapSlideButton()
}

class NewsListVC: UIViewController{
    
    let collectionCell          = "collectionCell"
    let tableCell               = "tableCell"
    
    let containerView           = UIView()
    let scrollView              = UIScrollView()
    let pageControl             = UIPageControl()
    let tableView               = UITableView()
    
    var swipeCollectionView     : UICollectionView!
    
    var newsArray: [Article]        = []
    var swipingImageArray:[String]  = []
    
    weak var delegate : NewsListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureThisVC()
        configureScroolView()
        configureContainerView()
        configureCollectionView()
        configurePageControl()
        configureTableView()
        getNews()        
    }
    
    
    func configureThisVC(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Yeni Haberler"
        let sideButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(didTapSlideMenuBtn))
        navigationItem.leftBarButtonItem = sideButton
    }
    
    
    @objc func didTapSlideMenuBtn(){
        delegate?.didTapSlideButton()
    }
    
    
    func configureScroolView(){
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.pinToEdges(subView: view)
    }
    
    
    func configureContainerView(){
        scrollView.addSubview(containerView)
        containerView.pinToEdges(subView: scrollView)
        
        //Double(tableView.rowHeight)
        
        let tableViewRowHeight  = 130.0
        let numberOfRows        = 20.0
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfRows * tableViewRowHeight)),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    func configureCollectionView(){
        swipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.swipingFlowlayout(view: view))
        containerView.addSubview(swipeCollectionView)
        
        swipeCollectionView.isPagingEnabled                 = true
        swipeCollectionView.showsHorizontalScrollIndicator  = false
        swipeCollectionView.dataSource                      = self
        swipeCollectionView.delegate = self
        swipeCollectionView.register(SwipeCollectionViewCell.self, forCellWithReuseIdentifier: collectionCell)
        
        swipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            swipeCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            swipeCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            swipeCollectionView.widthAnchor.constraint(equalTo: swipeCollectionView.heightAnchor, multiplier: 1.8)
        ])
        
    }
    
    
    func configurePageControl(){
        containerView.addSubview(pageControl)
        
        pageControl.currentPage                     = 0
        pageControl.numberOfPages                   = 5
        pageControl.pageIndicatorTintColor          = .gray
        pageControl.currentPageIndicatorTintColor   = .red
        pageControl.allowsContinuousInteraction     = false
        pageControl.isUserInteractionEnabled        = false
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: swipeCollectionView.bottomAnchor, constant: 5),
            pageControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    
    func configureTableView(){
        
        containerView.addSubview(tableView)
        
        tableView.rowHeight = 120
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: tableCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    
    func getNews(){
        showLoadingView()
        NetworkManager.shared.downloadNewsData {[weak self] result in
            guard let self = self else {return}
            self.dissmisLoadingView()
            switch result {
            case .success(let news):
                self.newsArray = news.articles
                
                for i in 0...4{
                    self.swipingImageArray.append(self.newsArray[i].urlToImage!)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.swipeCollectionView.reloadData()
                }
                
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
}


extension NewsListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell        = tableView.dequeueReusableCell(withIdentifier: tableCell) as! NewsTableViewCell
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

extension NewsListVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.swipingImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! SwipeCollectionViewCell
        cell.setImage(imageURL: self.swipingImageArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newsContent = NewsContentVC(news: self.newsArray[indexPath.item])
        navigationController?.pushViewController(newsContent, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let x:CGFloat = scrollView.contentOffset.x
        let currentPage = Int(x/pageWidth)
        
        pageControl.currentPage = currentPage
    }
    
}





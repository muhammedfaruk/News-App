//
//  SearchNewsVC.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 9.01.2022.
//

import UIKit

private let reuseIdentifier = "searchCVCell"

class SearchNewsVC: UIViewController {
    
    var collectionView : UICollectionView!
    
    var newsArray : [Article] = []
    
    var searchText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureSearchBar()
        getNews(searchText: searchText)
    }
    
    init(searchText: String) {
        super.init(nibName: nil, bundle: nil)
        self.searchText = searchText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureSearchBar(){
        let searchController                    = UISearchController()
        searchController.searchBar.placeholder  = "Ne tür bir haber arıyorsunuz?"
        searchController.searchBar.delegate     = self
        navigationItem.searchController         = searchController
    }
    
    
    func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: self.view))
        view.addSubview(collectionView)
        
        collectionView.dataSource      = self
        collectionView.delegate        = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    func getNews(searchText: String){
                
        NetworkManager.shared.searchNews(searchText: searchText) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            
            case .success(let news):
                
                self.newsArray = news.articles
                
                if self.newsArray.isEmpty{
                    self.presentAlertOnMainThread(title: "Hata", message: "Tekrar arama yapınız")
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.rawValue)
                self.presentAlertOnMainThread(title: "Hata", message: "Lütfen internet bağlantınızı kontrol ediniz")
            }
          }
        }
    }


extension SearchNewsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        cell.set(news: self.newsArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews    = self.newsArray[indexPath.item]
        let NewsContentVC   = NewsContentVC(news: selectedNews)
        navigationController?.pushViewController(NewsContentVC, animated: true)
    }
}


extension SearchNewsVC: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            let searchText = searchBar.text!.lowercased().trimmingCharacters(in:.whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            getNews(searchText: searchText!)
        }

    }
}

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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
 
        configureCollectionView()
        configureSearchBar()
        getNews(searchText: "car") // this is a first news for search screen
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
        collectionView.backgroundColor = .clear
        
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    func getNews(searchText: String){
 
        NetworkManager.shared.searchNews(searchText: searchText) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let news):
                self.newsArray = news.articles
            case .failure(let error):
                print(error.rawValue)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
        
}


extension SearchNewsVC: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text!.lowercased().trimmingCharacters(in:.whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        getNews(searchText: searchText!)
    }
}

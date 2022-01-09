//
//  SwipingCollectionView.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 3.01.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class SwipingCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var imageArray : [String?] = []
    var newsArray  : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getNewsInfo()
        configureCollectionView()
        configureFlowLayout()
    }
    
    
    private func configureCollectionView(){
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView!.register(SwipeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    private func configureFlowLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
    }
    
    
    private func getNewsInfo(){
        showLoadingView()
        NetworkManager.shared.downloadNewsData {[weak self] result in
            guard let self = self else {return}
            self.dissmisLoadingView()
            
            switch result {
            case .success(let news):
                self.newsArray = news.articles
                // get only last 5 news photo
                for i in (0...4) {
                    self.imageArray.append(news.articles[i].urlToImage)
                }
                
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
        let x               = targetContentOffset.pointee.x
        let currentPageInt  = Int(x / view.frame.width)
        
        let currentPageInfo: [String: Int] = ["currentPageValue": currentPageInt]
 
        NotificationCenter.default.post(name: NSNotification.Name("change"), object: nil, userInfo: currentPageInfo)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SwipeCollectionViewCell
     
        let imageUrl = self.imageArray[indexPath.item]
        cell.setImage(imageURL: imageUrl ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newsArticle = self.newsArray[indexPath.item]
        let contentVC = NewsContentVC(news: newsArticle)
        
        navigationController?.pushViewController(contentVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

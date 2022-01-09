//
//  SwipeCollectionViewCell.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 3.01.2022.
//

import UIKit

class SwipeCollectionViewCell: UICollectionViewCell {
    
    let imageView = CustomImageView(image: nil, highlightedImage: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false        
        imageView.pinToEdges(subView: self)
    }
    
    func setImage(imageURL : String){
        imageView.downloadImage(imageURL: imageURL)
    }
    
}

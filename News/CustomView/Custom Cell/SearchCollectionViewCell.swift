//
//  SearchCollectionViewCell.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 10.01.2022.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView   = CustomImageView(frame: .zero)
    let titleLabel  = CustomTitleLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(news: Article){ 
        self.imageView.setImage(imageURL: news.urlToImage ?? "")
        self.titleLabel.text = news.title
    }
    
    
    private func configure(){
        addSubview(imageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    
}

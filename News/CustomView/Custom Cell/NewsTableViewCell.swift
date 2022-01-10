//
//  NewsTableViewCell.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 20.12.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var newsTitle        = CustomTitleLabel(textAlignment: .left)
    var newsImage        = CustomImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        addSubview(newsTitle)
        addSubview(newsImage)
      
        configureMessageLabel()
        configureNewsImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article){
        self.newsTitle.text = article.title
        newsImage.setImage(imageURL: article.urlToImage ?? "")
    }
    
    
    func configureMessageLabel(){
           NSLayoutConstraint.activate([
               newsTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
               newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
               newsTitle.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -12),
               newsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
           ])
       }
       
       
       func configureNewsImage(){
           NSLayoutConstraint.activate([
               newsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
               newsImage.bottomAnchor.constraint(equalTo: newsTitle.bottomAnchor),
               newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor, multiplier: 16/13)
           ])
       }
}

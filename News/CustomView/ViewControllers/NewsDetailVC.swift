//
//  NewsDetailVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 31.12.2021.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    let scrollView       = UIScrollView()
    let containerView    = UIView()
    
    let titleImage       = CustomImageView(frame: .zero)
    let newsTitleLabel   = CustomTitleLabel(textAlignment: .left)
    let contentLabel     = CustomBodyLabel(textAlignment: .left, color: .label)
    let authorLabel      = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        addSubViews()
        configureScrollView()
        configureLayoutUI()
        configureUIElements()
    }

    
    func addSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(titleImage)
        containerView.addSubview(newsTitleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(authorLabel)
    }
    
    func configureScrollView(){
        scrollView.pinToEdges(subView: view)
        containerView.pinToEdges(subView: scrollView)
    }
    
    
    init(news : Article){
        super.init(nibName: nil, bundle: nil)
        newsTitleLabel.text = news.title
        contentLabel.text   = ExampleText.testContent
        titleImage.downloadImage(imageURL: news.urlToImage ?? "")
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    func configureUIElements(){
        authorLabel.text                        = "Yazar: Muhammed Faruk Söğüt"
        authorLabel.numberOfLines               = 1
        authorLabel.adjustsFontSizeToFitWidth   = true
        authorLabel.font                        = UIFont.systemFont(ofSize: 50, weight: .light)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLayoutUI() {
        
        let padding: CGFloat             = 20
        let textImagePadding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            newsTitleLabel.topAnchor.constraint(equalTo:containerView.safeAreaLayoutGuide.topAnchor),
            newsTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: textImagePadding),
            newsTitleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -textImagePadding),
            newsTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            authorLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor),
            authorLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -textImagePadding),
            authorLabel.heightAnchor.constraint(equalToConstant: padding),
                                    
            titleImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: textImagePadding),
            titleImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -45),
            titleImage.heightAnchor.constraint(equalToConstant: 200),
            
            contentLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: padding),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: textImagePadding),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -textImagePadding),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -60),
                
        ])
    }

}

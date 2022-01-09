//
//  WriterTableCell.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 4.01.2022.
//

import UIKit

class WriterTableCell: UITableViewCell {

    var profilePhoto  = CustomImageView(frame: .zero)
    var writerName    = CustomTitleLabel(textAlignment: .left)
    var topicView     = UIView()
    var topicText     = CustomBodyLabel(textAlignment: .left, color: .white)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(writerInfo : Writer){
        profilePhoto.image  = UIImage(systemName: writerInfo.image)
        writerName.text     = writerInfo.name
        topicText.text      = writerInfo.topic
    }
    
    
    private func configure(){
        addSubview(profilePhoto)
        addSubview(writerName)
        addSubview(topicView)
        topicView.addSubview(topicText)
       
        topicView.backgroundColor = UIColor.systemGray
        
        // Random color = UIColor(cgColor: CGColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 0.5))
        
        topicView.layer.cornerRadius    = 3
        topicView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            profilePhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profilePhoto.widthAnchor.constraint(equalToConstant: 80),
            profilePhoto.heightAnchor.constraint(equalToConstant: 80),
            
            writerName.topAnchor.constraint(equalTo: profilePhoto.topAnchor),
            writerName.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 20),
            writerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            writerName.heightAnchor.constraint(equalToConstant: 30),
            
            topicView.bottomAnchor.constraint(equalTo: profilePhoto.bottomAnchor),
            topicView.leadingAnchor.constraint(equalTo: writerName.leadingAnchor),
            topicView.trailingAnchor.constraint(equalTo: writerName.trailingAnchor, constant: -40),
            topicView.heightAnchor.constraint(equalToConstant: 20),
            
            topicText.centerYAnchor.constraint(equalTo: topicView.centerYAnchor),
            topicText.centerXAnchor.constraint(equalTo: topicView.centerXAnchor)
        ])
    }
}

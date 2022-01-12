//
//  UIView+Ext.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 1.01.2022.
//

import UIKit

extension UIView{
    
    func pinToEdges(subView: UIView) {

        translatesAutoresizingMaskIntoConstraints = false
         
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: subView.topAnchor),
            leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            bottomAnchor.constraint(equalTo: subView.bottomAnchor)
        ])
    }
    
}

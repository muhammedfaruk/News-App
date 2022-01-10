//
//  UIHelper.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 9.01.2022.
//

import UIKit

enum UIHelper {
    
   static func createThreeColumnFlowLayout(view : UIView) -> UICollectionViewFlowLayout{
        
        let width                       = view.bounds.width
        let padding:CGFloat             = 12
        let minimumItemSpacing:CGFloat  = 5
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 2
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}

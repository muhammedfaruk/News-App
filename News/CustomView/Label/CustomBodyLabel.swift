//
//  CustomBodyLabel.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 27.12.2021.
//

import UIKit

class CustomBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, color: UIColor){
        super.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.textColor      = color
        configure()
    }
    
    
    func configure(){
        numberOfLines               = 0
        adjustsFontSizeToFitWidth   = true
        font                        = UIFont.preferredFont(forTextStyle: .body)        
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
    }

}

//
//  CustomTitleLabel.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 27.12.2021.
//

import UIKit

class CustomTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment  = textAlignment
        configure()
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines               = 0
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        font                        = UIFont.systemFont(ofSize: 16, weight: .bold)
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        sizeToFit()
    }
}

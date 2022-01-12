//
//  SideMenu.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 12.01.2022.
//

import Foundation

struct MenuContent{
    let title : String
    let image : String
}


struct MenuContentInfo{
    static let education   = MenuContent(title: "Eğitim", image: "text.book.closed.fill")
    static let technology  = MenuContent(title: "Teknoloji", image: "bolt.horizontal.fill")
    static let science     = MenuContent(title: "Bilim", image: "globe.americas.fill")
    static let magazin     = MenuContent(title: "Magazin", image: "play.rectangle.fill")
    
}

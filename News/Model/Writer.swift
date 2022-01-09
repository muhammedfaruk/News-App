//
//  Writer.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 4.01.2022.
//

import Foundation

struct Writer {
    let name    : String
    let image   : String
    let topic   : String
}


enum WriterInfo {
    static var Faruk         = Writer(name: "MUHAMMED FARUK SÖĞÜT", image: "person.crop.circle.fill", topic: "Teknoloji")
    static var Ayşe          = Writer(name: "AYŞE GÜLÇİN", image: "person.crop.circle.fill", topic: "Magazin")
    static var Sinan         = Writer(name: "SİNAN ALABAY", image: "person.crop.circle.fill", topic: "Bilim")
    static var Sabahattin    = Writer(name: "SABAHATTİN ERGİNEL", image: "person.crop.circle.fill", topic: "Siyaset")
}


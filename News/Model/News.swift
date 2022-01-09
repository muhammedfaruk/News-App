
import UIKit



struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
  //let source: Source
    var author: String?
    let title: String
    var description: String?
    let url: String
    var urlToImage: String?
    var content: String?
}


struct Source: Codable {
    var id: String?
    let name: String
}

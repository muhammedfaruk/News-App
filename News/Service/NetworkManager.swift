//
//  NetworkManager.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 19.12.2021.
//
import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    let baseURL         = "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=ccc880d59b46414e93d693b98303a674"
 
    let cash            = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadNewsData(completion : @escaping (Result<News, errorMessages>)  -> Void) {
     
        guard let url = URL(string: baseURL) else {
            completion(.failure(.url))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.URLsession))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.response))
                return
            }
            
            guard let data = data else {
                completion(.failure(.URLsession))
                return
            }

            
            do{
                let news = try JSONDecoder().decode(News.self, from: data)
                completion(.success(news))
                
            } catch {
                completion(.failure(.decode))
            }

        }
        task.resume()
    }
    
    func searchNews(searchText: String, completion : @escaping (Result<News, errorMessages>)  -> Void) {
       
        guard !searchText.isEmpty else {return}
        
       let searchURL  = "https://newsapi.org/v2/everything?qInTitle=\(searchText)&apiKey=ccc880d59b46414e93d693b98303a674"
                          
       guard let url = URL(string: searchURL) else {
           completion(.failure(.url))
           return
       }
       
       let task = URLSession.shared.dataTask(with: url) { data, response, error in
           
           if let _ = error {
               completion(.failure(.URLsession))
               return
           }
           
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
               completion(.failure(.response))
               return
           }
           
           guard let data = data else {
               completion(.failure(.URLsession))
               return
           }

           
           do{
               let news = try JSONDecoder().decode(News.self, from: data)
               completion(.success(news))
               
           } catch {
               completion(.failure(.decode))
           }

       }
       task.resume()
   }   
}




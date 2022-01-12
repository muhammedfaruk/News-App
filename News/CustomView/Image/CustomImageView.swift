//
//  CustomImageView.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 27.12.2021.
//

import UIKit

class CustomImageView: UIImageView {
    
    let placeholder     = UIImage(named: "placeholder")
    let cache            = NetworkManager.shared.cash
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.image              = placeholder
        clipsToBounds = true
        contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(){
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholder
        translatesAutoresizingMaskIntoConstraints = false        
    }
    
    
    func setImage(imageURL: String){
        
        let cacheKey = NSString(string: imageURL)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: imageURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self,
            
                  error == nil,            
                  let response = response as? HTTPURLResponse,response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {return}

            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        task.resume()
    }
}

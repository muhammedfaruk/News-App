//
//  UIViewController + Ext.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 27.12.2021.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dissmisLoadingView(){
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func presentAlertOnMainThread(title:String, message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Tamam", style: .default)
            alert.addAction(alertButton)
            self.present(alert, animated: true)
        }
    }
    
}

//
//  SideMenu.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 12.01.2022.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func didTapSideContent(menuItem: MenuContent)
}

class SideMenu: UIViewController {
    
    var tableView   = UITableView()
    let imageView   = UIImageView()
    
    let contentArray:[MenuContent] = [MenuContentInfo.education, MenuContentInfo.technology,MenuContentInfo.science,MenuContentInfo.magazin]
    
    weak var delegate: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        configureImageView()
        configureTableView()
    }
    
    
    func configureImageView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image                 = UIImage(named: "sideLogo")
        imageView.layer.cornerRadius    = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.bounds.size.width - 100),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SideMenu: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = self.contentArray[indexPath.row].title
        
        let configuration = UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
        let image                   = UIImage(systemName: contentArray[indexPath.row].image, withConfiguration: configuration)
        content.image               = image
        cell.contentConfiguration   = content
        cell.accessoryType          = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didTapSideContent(menuItem: self.contentArray[indexPath.row])
    }
    
}

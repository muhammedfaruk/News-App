//
//  WriterVC.swift
//  NewsProgramatically
//
//  Created by Muhammed Faruk Söğüt on 4.01.2022.
//

import UIKit



class WriterVC: UIViewController {
    
    let tableView   = UITableView()
    let cellKey     = "writerTableCell"
    
    let writer : [Writer] = [WriterInfo.Faruk, WriterInfo.Ayşe, WriterInfo.Sabahattin, WriterInfo.Sinan]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight  = 100
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.pinToEdges(subView: view)
        
        tableView.register(WriterTableCell.self, forCellReuseIdentifier: cellKey)
    }
    

}

extension WriterVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.writer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellKey) as! WriterTableCell
        
        cell.set(writerInfo: self.writer[indexPath.row])
        
        return cell
    }
    
    
}

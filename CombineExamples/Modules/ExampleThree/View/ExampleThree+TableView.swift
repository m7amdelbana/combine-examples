//
//  ExampleThree+TableView.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 04/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit

extension ExampleThreeViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    
    func setupTableView() {
        tableView.registerCellNib(cellClass: PostCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: PostCell.self)
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

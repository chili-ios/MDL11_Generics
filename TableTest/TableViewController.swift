//
//  TableViewController.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    internal let viewModel = TableViewModel()
    lazy private(set) var tableDirector: TableDirector = {
        return TableDirector(tableView: self.tableView, items: self.viewModel.items)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()

        self.addHandlers()
    }

    private func addHandlers() {
        self.tableDirector.actionsProxy.on(.didSelect) { (c: UserCellConfig, cell) in
            print("did select user cell", c.item, cell)
        }.on(.custom(UserCell.userFollowAction)) { (c: UserCellConfig, cell) in
            print("follow user", c.item)
        }.on(.didSelect) { (c: ImageCellConfig, cell) in
            print("did select image cell", c.item, cell)
        }
    }

    @IBAction func onUpdate(_ sender: Any) {
        self.viewModel.update()
        self.tableDirector.update(items: self.viewModel.items)
    }
}

//
//  TableDirector.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 29/10/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class TableDirector: NSObject {
    let tableView: UITableView
    let actionsProxy = CellActionProxy()
    private(set) var items = [CellConfigurator]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    init(tableView: UITableView, items: [CellConfigurator]) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.items = items

        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(n:)), name: CellAction.notificationName, object: nil)
    }

    @objc fileprivate func onActionEvent(n: Notification) {
        if let eventData = n.userInfo?["data"] as? CellActionEventData,
            let cell = eventData.cell as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) {
            actionsProxy.invoke(action: eventData.action, cell: cell, configurator: self.items[indexPath.row])
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TableDirector: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = self.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellConfigurator).reuseId, for: indexPath)
        cellConfigurator.configure(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellConfigurator = self.items[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        self.actionsProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfigurator)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellConfigurator = self.items[indexPath.row]
        self.actionsProxy.invoke(action: .willDisplay, cell: cell, configurator: cellConfigurator)
    }
}

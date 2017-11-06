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
            if oldValue.isEmpty {
                self.tableView.reloadData()
            } else {
                let oldHashes = oldValue.map { $0.hash }
                let newHashes = items.map { $0.hash }
                let result = DiffList.diffing(oldArray: oldHashes, newArray: newHashes)
                self.tableView.perform(result: result)
            }
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

    func update(items: [CellConfigurator]) {
        self.items = items
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

extension UITableView {
    func perform(result: DiffList.Result) {
        if result.hasChanges {
            self.beginUpdates()
            if !result.deletes.isEmpty {
                self.deleteRows(at: result.deletes.flatMap { IndexPath(row: $0, section: 0) }, with: .automatic)
            }
            if !result.inserts.isEmpty {
                self.insertRows(at: result.inserts.flatMap { IndexPath(row: $0, section: 0) }, with: .automatic)
            }
            if !result.updates.isEmpty {
                self.reloadRows(at: result.updates.flatMap { IndexPath(row: $0, section: 0) }, with: .automatic)
            }
            if !result.moves.isEmpty {
                result.moves.forEach({ (index) in
                    let toIndexPath = IndexPath(row: index.to, section: 0)
                    self.moveRow(at: IndexPath(row: index.from, section: 0), to: toIndexPath)
                })
            }
            self.endUpdates()
        }
    }
}

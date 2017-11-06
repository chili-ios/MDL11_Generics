//
//  CellConfigurator.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 30/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    static var reuseIdentifier: String { get }
    associatedtype DataType
    func configure(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    var hash: Int { get }
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType: Hashable>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    static var reuseId: String { return CellType.reuseIdentifier }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }

    var hash: Int {
        return String(describing: CellType.self).hashValue ^ item.hashValue
    }
}

extension Int: Diffable {
    public var diffIdentifier: AnyHashable {
        return self
    }
}

//
//  TableViewModel.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

typealias UserCellConfig = TableCellConfigurator<UserCell, User>
typealias MessageCellConfig = TableCellConfigurator<MessageCell, String>
typealias ImageCellConfig = TableCellConfigurator<ImageCell, URL>

class TableViewModel {
    private (set) var items: [CellConfigurator] = [
        UserCellConfig.init(item: User(name: "John Smith", imageName: "user3")),
        
        MessageCellConfig.init(item: "Hi, this is a message text. Tra la la. Tra la la."),
        ImageCellConfig.init(item: Bundle.main.url(forResource: "beach@2x", withExtension: "jpg")!),
        UserCellConfig.init(item:User(name: "Jessica Wood", imageName: "user2")),
        MessageCellConfig.init(item: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        TableCellConfigurator<WarningCell, String>.init(item: "Hey!! It's a warning!!!!")
    ]

    func update() {
        self.items = [
            ImageCellConfig.init(item: Bundle.main.url(forResource: "beach@2x", withExtension: "jpg")!),
            TableCellConfigurator<WarningCell, String>.init(item: "Hey!! It's a warning!!!!"),
            UserCellConfig.init(item:User(name: "Janet Jackson", imageName: "user2")),
            MessageCellConfig.init(item: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
            UserCellConfig.init(item: User(name: "John Smith", imageName: "user3")),
            MessageCellConfig.init(item: "Hi, this is a message text. Tra la la. Tra la la."),
        ]
    }
}

//
//  TableViewModel.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class TableViewModel {
    let items: [Any] = [
        User(name: "John Smith", imageName: "user3"),
        "Hi, this is a message text. Tra la la. Tra la la.",
        Bundle.main.url(forResource: "beach@2x", withExtension: "jpg")!,
        User(name: "Jessica Wood", imageName: "user2"),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    ]
}

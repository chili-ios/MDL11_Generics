//
//  Data.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let imageName: String
}

extension User: Hashable {
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        return name.hashValue ^ imageName.hashValue
    }
}

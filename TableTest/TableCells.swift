//
//  TableCells.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    static let userFollowAction = "UserFollowAction"

    func configure(data user: User) {
        avatarView.image = UIImage(named: user.imageName)
        userNameLabel.text = user.name
    }
    
    @IBAction func onFollowTap(_ sender: Any) {
        CellAction.custom(type(of: self).userFollowAction).invoke(cell: self)
    }
}


class MessageCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var messageLabel: UILabel!

    func configure(data message: String) {
        messageLabel.text = message
    }
}


class ImageCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var pictureView: UIImageView!

    func configure(data url: URL) {
        if let data = try? Data(contentsOf: url) {
            self.pictureView.image = UIImage(data: data)
        }
    }
}

class WarningCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(data message: String) {
        messageLabel.text = message
    }
}

//
//  TableCells.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    func configure(user: User) {
        avatarView.image = UIImage(named: user.imageName)
        userNameLabel.text = user.name
    }
}


class MessageCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!

    func configure(message: String) {
        messageLabel.text = message
    }
}


class ImageCell: UITableViewCell {
    @IBOutlet weak var pictureView: UIImageView!

    func configure(url: URL) {
        if let data = try? Data(contentsOf: url) {
            self.pictureView.image = UIImage(data: data)
        }
    }
}

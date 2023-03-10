//
//  MessageCell.swift
//  Eliza bot
//
//  Created by Тимур Чеберда on 10.03.2023.
//

import UIKit

final class MessageCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    var message: String? {
        didSet { label.text = message }
    }
}

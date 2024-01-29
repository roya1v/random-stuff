//
//  ChatTableViewCell.swift
//  Tinderque-View
//
//  Created by Mike S. on 29/01/2024.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundView?.backgroundColor = .purple
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

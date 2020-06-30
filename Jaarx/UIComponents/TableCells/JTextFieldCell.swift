//
//  JTextFieldCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit
import TextFieldEffects

class JTextFieldCell: UITableViewCell {

    @IBOutlet weak var tfInfo: AkiraTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        tfInfo.borderColor = .clear
        tfInfo.textColor = .white
        tfInfo.placeholderColor = .black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

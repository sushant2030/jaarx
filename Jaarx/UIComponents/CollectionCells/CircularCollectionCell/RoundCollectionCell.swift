//
//  RoundCollectionCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RoundCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.link.cgColor
        self.layer.borderWidth = 1.0
    }
    func deSelect()  {
        lblDay.textColor = .link
        lblNumber.textColor = .link
        backgroundColor = .white
    }
    
    func selectCell()  {
        lblDay.textColor = .white
        lblNumber.textColor = .white
        backgroundColor = .link
    }

}



//
//  BucketCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 04/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class BucketCell: UITableViewCell {

    @IBOutlet weak var containerCollectionView: UICollectionView!
    @IBOutlet weak var bucketDescriptionLabel: UILabel!
    @IBOutlet weak var bucketTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

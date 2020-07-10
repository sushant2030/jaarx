//
//  LongCollectionCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 04/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class LongCollectionCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var btnPreOrder: UIButton!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var squareImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setRestData(restaurantData:RestaurantData) {
        descriptionLabel.text = restaurantData.restaurantLocation ?? ""
        titleLabel.text = restaurantData.restaurantName
    }

}

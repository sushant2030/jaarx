//
//  SquareCollectionCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 04/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class SquareCollectionCell: UICollectionViewCell {

    @IBOutlet weak var squareImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setRestData(restaurantData:RestaurantData) {
        if let imageUrl = URL.init(string:restaurantData.imageDetails![0].imageUrl!){
            squareImageView.downloaded(from: imageUrl)
        }
    }
}

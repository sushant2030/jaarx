//
//  SquareCollectionCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 04/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class SquareCollectionCell: UICollectionViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var squareImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        shadowView.dropShadow()
    }

}

extension SquareCollectionCell:CellConfigurable
{
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantCellVM) else {return}
        let i = arc4random() % 10
        squareImageView.image = UIImage.init(named: (i % 2 == 0) ? "foodTwo" : ((i % 3 == 0) ? "foodThree" : "foodOne" ))
        if let imageUrl = viewModel.imageUrl{
            squareImageView.downloaded(from:imageUrl)
        }
    }
}

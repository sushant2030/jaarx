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
        shadowView.dropShadow()
    }

}

extension SquareCollectionCell:CellConfigurable
{
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantCellVM) else {return}
        if let imageUrl = viewModel.imageUrl{
            squareImageView.downloaded(from:imageUrl)
        }
    }
}

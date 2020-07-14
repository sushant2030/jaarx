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
    var restaurantCellVM : RestaurantCellVM?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
       
    }
    
}

extension LongCollectionCell:CellConfigurable
{
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantCellVM) else {return}
        self.restaurantCellVM = viewModel
        descriptionLabel.text = viewModel.location
        titleLabel.text = viewModel.title
        if let imageUrl = viewModel.imageUrl{
            squareImage.downloaded(from:imageUrl)
        }
    }
}

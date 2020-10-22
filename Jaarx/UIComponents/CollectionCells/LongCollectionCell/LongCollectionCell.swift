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
    @IBOutlet weak var shadowView: UIView!
    var restaurantCellVM : RestaurantCellVM?
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.dropShadow()
        btnScan.makeViewCornerRadiusWithRadi(radius: btnScan.frame.size.height / 2)
        btnScan.makeAppThemeColorBorder()
        btnPreOrder.makeViewCornerRadiusWithRadi(radius: btnScan.frame.size.height / 2)
        btnPreOrder.makeAppThemeColorBorder()
        btnPreOrder.dropShadow()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
 
    }
    @IBAction func actionScan(_ sender: Any) {
        restaurantCellVM?.cellButtonAction?(.scan)
    }
    
    @IBAction func actionPreOrder(_ sender: UIButton) {
        restaurantCellVM?.cellButtonAction?(.preOrder)
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

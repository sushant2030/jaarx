//
//  TagCollectionCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        makeViewCornerRadiusWithRadi(radius: self.frame.height/2)
        dropShadow()
    }
}
extension TagCollectionCell:CellConfigurable
{
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantCellVM) else {return}
        if let categoryName = viewModel.categoryName{
            self.tagLabel.text = categoryName
        }
        if let categoryColor = viewModel.categoryColor {
            self.backgroundColor = UIColor.init(hex: categoryColor)
        }
    }
}

//
//  OrderListShadowCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 21/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class OrderListShadowCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lblItemCost: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDishName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.makeViewCornerRadiusWithRadi(radius: 5.0)
        makeViewCornerRadiusWithRadi(radius: 5.0)
        holderView.dropShadow(scale: true)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension OrderListShadowCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? CartFoodVM {
            lblCost.text = "₹\(viewModel.totalPrice ?? "")"
            lblCount.text = "x \(viewModel.quantity ?? "")"
            lblDishName.text = viewModel.dishName ?? ""
            lblItemCost.text = "₹\(viewModel.originalPrice ?? "")"
        }
    }
}

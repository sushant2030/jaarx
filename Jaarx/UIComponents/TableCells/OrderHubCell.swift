//
//  OrderHubCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class OrderHubCell: UITableViewCell {

    @IBOutlet weak var vegBulletImageView: UIImageView!
    @IBOutlet weak var orderTimeView: UIView!
    @IBOutlet weak var foodQuantity: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
        
        // Initialization code
    }
    func configureViews()  {
        orderTimeView.layer.borderWidth = 1.0
        orderTimeView.layer.borderColor = UIColor().getHexColor(hex: "#FFCC00").cgColor
        orderTimeView.makeViewCornerRadiusWithRadi(radius: 5.0)
        holderView.makeViewCornerRadiusWithRadi(radius: 5.0)
        holderView.dropShadow(scale: true)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension OrderHubCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? CartFoodVM {
            foodPrice.text = "₹\(viewModel.totalPrice ?? "0.0")"
            foodTitle.text = viewModel.dishName
            let veg = viewModel.isVeg ?? true
            vegBulletImageView.image = UIImage.init(named: veg ? "veg" : "nonVeg")
            foodQuantity.text = viewModel.quantity ?? "1"
            
        }
    }
}

//
//  EditCartCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 27/09/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class EditCartCell: UITableViewCell {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var lblFoodCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    var cartItemModel : FoodDetails?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionAdd(_ sender: UIButton) {
        if let quantity = cartItemModel?.cartQuantity {
            cartItemModel?.cartQuantity += 1
            lblFoodCount.text = "\(quantity + 1)"
        }
    }
    
    @IBAction func actionRemove(_ sender: Any) {
        if let quantity = cartItemModel?.cartQuantity, quantity > 0 {
            cartItemModel?.cartQuantity -= 1
            lblFoodCount.text = "\(quantity - 1)"
        }
    }
}
 
extension EditCartCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? FoodDetails {
            cartItemModel = viewModel
            lblFoodCount.text = "\(viewModel.quantity!)"
            lblTitle.text = viewModel.dishName
            lblDescription.text = viewModel.dishDescription
            lblFoodCount.text = "\(viewModel.cartQuantity)"
        }
    }
}

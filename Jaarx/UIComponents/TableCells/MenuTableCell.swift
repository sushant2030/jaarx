//
//  MenuTableCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnRemoveQuantity: UIButton!
    @IBOutlet weak var btnAddQuantity: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var menuButtonHolder: UIView!
    @IBOutlet weak var buttonHolderView: UIStackView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var indicatorImage: UIImageView!
    var foodDetailVM : FoodDetails!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
        // Initialization code
    }

    func updateViews()  {
        btnMenu.makeViewCornerRadiusWithRadi(radius: 5)
        btnMenu.layer.borderWidth = 1.0
        menuButtonHolder.layer.borderWidth = 1.0
        btnMenu.layer.borderColor = UIColor().getHexColor(hex: "#AFAFAF").cgColor
        menuButtonHolder.layer.borderColor = UIColor().getHexColor(hex: "#AFAFAF").cgColor
        menuButtonHolder.makeViewCornerRadiusWithRadi(radius: 5)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK : - IBOutlets
    @IBAction func actionMenu(_ sender: UIButton) {
        if let foodVM = foodDetailVM {
//            let cart = Cart.init(withFoodId: Int(foodVM.foodId ?? "0") ?? 0, quantity: 1, dishName: foodVM.dishName ?? "", description: foodVM.dishDescription ?? "", price: foodVM.dishPrice ?? "0")
            UserDataSource.sharedInstance.carts.value.append(foodVM)
        }
        showQuantityButton()
    }
    @IBAction func actionRemoveQuantity(_ sender: UIButton) {
        let modifyingItem : [FoodDetails] = UserDataSource.sharedInstance.carts.value.filter{ $0.foodId! == foodDetailVM.foodId! }
        if modifyingItem.count > 0 {
            let cart = modifyingItem[0]
            cart.cartQuantity -= 1
            lblQuantity.text = "\(cart.cartQuantity)"
        }
    }
    
    @IBAction func actionAddQuantity(_ sender: UIButton) {
        let modifyingItem : [FoodDetails] = UserDataSource.sharedInstance.carts.value.filter{ $0.dishName! == foodDetailVM.dishName! }
//        if modifyingItem.count > 0 {
            let cart = modifyingItem[0]
            cart.cartQuantity += 1
            lblQuantity.text = "\(cart.cartQuantity)"
//        }
        print(modifyingItem)
    }
    
    
    func showQuantityButton() {
         let modifyingItem : [FoodDetails] = UserDataSource.sharedInstance.carts.value.filter{ $0.dishName! == foodDetailVM.dishName! }
        let cart = modifyingItem[0]
        cart.cartQuantity += 1
        lblQuantity.text = "\(cart.cartQuantity)"
        menuButtonHolder.isHidden = false
        btnMenu.isHidden = true
        
    }
}

extension MenuTableCell: CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? FoodDetails {
            foodDetailVM = viewModel
            self.lblTitle.text = viewModel.dishName
            self.lblDescription.text = viewModel.dishDescription
            self.lblPrice.text = viewModel.dishPrice
            if let image = viewModel.getImageUrl() {
                self.foodImageView.downloaded(from: image)
            }
            if let isVeg = viewModel.vegan {
                indicatorImage.image = UIImage.init(named: isVeg ? "veg" : "nonVeg")
            }
            menuButtonHolder.isHidden = true
        }
    }
    
    
}

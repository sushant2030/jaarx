//
//  SearchTableCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RestaurantListCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRestaurantTitle: UILabel!
    @IBOutlet weak var btnPreOrder: UIButton!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var searchedImageView: UIImageView!
    var searchData:SearchData?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    func setupUI() {
        holderView.layer.borderColor = UIColor.gray.cgColor
        holderView.layer.cornerRadius = 15.0
        holderView.layer.masksToBounds = true
        btnScan.layer.borderColor = UIColor.blue.cgColor
        btnScan.layer.borderWidth = 1.0
        btnPreOrder.layer.borderColor = UIColor.blue.cgColor
        btnPreOrder.layer.borderWidth = 1.0
        holderView.layer.borderWidth = 1.0
        btnScan.layer.cornerRadius = btnScan.bounds.size.height / 2
        btnPreOrder.layer.cornerRadius =  btnScan.bounds.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionScan(_ sender: UIButton) {
        searchData?.cellButtonAction?(.scan)
    }
    
    @IBAction func actionPreOrder(_ sender: UIButton) {
        searchData?.cellButtonAction?(.preOrder)
    }
}

extension RestaurantListCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let searchVM = (viewModel as? SearchData) {
            self.searchData = searchVM
            lblDescription.text = searchVM.location
            lblRestaurantTitle.text = searchVM.restaurantName
            if searchVM.type == .restaurant {
                if let imagePathURL = searchVM.getImageUrl(){
                    searchedImageView.downloaded(from: imagePathURL)
                }
            }
        }
    }
    
    
}

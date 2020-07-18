//
//  SearchTableCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class SearchTableCell: UITableViewCell {

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
        holderView.layer.borderColor = UIColor.green.cgColor
        btnScan.layer.cornerRadius = 15.0
        btnPreOrder.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionScan(_ sender: UIButton) {
        searchData?.actionOnCell?(.scan)
    }
    
    @IBAction func actionPreOrder(_ sender: UIButton) {
        searchData?.actionOnCell?(.preOrder)
    }
}

extension SearchTableCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let searchVM = (viewModel as? SearchData) {
            self.searchData = searchVM
            lblDescription.text = searchVM.location
            lblRestaurantTitle.text = searchVM.restaurantName
        }
    }
    
    
}

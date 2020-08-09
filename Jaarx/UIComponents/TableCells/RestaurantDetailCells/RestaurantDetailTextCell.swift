//
//  RestaurantDetailTextCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // add shadow on cell
        configureCellContainerView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellUIForCell(type:RestaurantDetailCellType) {
        switch type {
        case .ScanNOrder:
            configureScanNOrderTypeCellUI()
        case .ReserveNOrder:
            configureReserveNOrderTypeCellUI()
        }
    }
    func configureCellContainerView(){
        containerView.dropShadow()
        containerView.layer.cornerRadius = 20.0
    }
    func configureScanNOrderTypeCellUI() {
        self.containerView.backgroundColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
        self.headingLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.descriptionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.subTextLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.typeImageView.image = UIImage(named:"QRIcon")
        self.subTextLabel.text = "Scan and order >"
    }
    func configureReserveNOrderTypeCellUI() {
        self.containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.headingLabel.textColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
        self.descriptionLabel.textColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
        self.subTextLabel.textColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
        self.typeImageView.image = UIImage(named:"WaitTimeIcon")
        self.subTextLabel.text = "Reserve and order >"
    }
}

extension RestaurantDetailTextCell : CellConfigurable {
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantTextVM) else {return}
        self.headingLabel.text = viewModel.titleText
        self.descriptionLabel.text = viewModel.descriptionText
        if let cellType = viewModel.cellType{
        self.configureCellUIForCell(type: cellType)
        }
    }
    
}

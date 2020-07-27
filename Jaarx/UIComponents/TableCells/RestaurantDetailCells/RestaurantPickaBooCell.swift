//
//  RestaurantPickaBooCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RestaurantPickaBooCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickaBooImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView?.layer.cornerRadius = 30.0
        self.pickaBooImageView?.layer.cornerRadius = 30.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RestaurantPickaBooCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? RestaurantPickaBooVM) else {return}
        if let imageURL = viewModel.imageUrl{
        self.pickaBooImageView.downloaded(from: imageURL)
        }
    }
    
}

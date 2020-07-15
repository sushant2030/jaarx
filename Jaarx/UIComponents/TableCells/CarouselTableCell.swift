//
//  CarouselTableCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 15/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class CarouselTableCell: UITableViewCell {
    
    @IBOutlet weak var carouselImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CarouselTableCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
//        guard let viewModel = (viewModel as? HomeRowVM) else {
//            return
//        }
        if let imageURL = URL.init(string: "https://www.bootstrapdash.com/wp-content/uploads/2019/09/best-selling-restaurant-website-templates-1.gif") {
            carouselImageView.downloaded(from: imageURL)
        }
        
    }
}

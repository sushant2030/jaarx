//
//  CarouselCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 03/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    @IBOutlet weak var carouselImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
extension CarouselCell:CellConfigurable
{
    func setup(viewModel: RowViewModel) {
        //TODO: Remove these hard code urls from this file and get them from the home url.
        //TODO: Also if possible do not use collection Cell for setting data on UITableViewCell directly set the data on uitableviewcell
        guard let viewModel = (viewModel as? HomeRowVM) else {return}
        switch viewModel.bucketType {
        case .banner,.carousel:
            self.carouselImage.downloaded(from: URL.init(string:"https://www.bootstrapdash.com/wp-content/uploads/2019/09/best-selling-restaurant-website-templates-1.gif")!)
        case .scanAndOrder:
            self.carouselImage.downloaded(from:URL.init(string:"https://cdn.crn.in/wp-content/uploads/2020/05/25105053/M2.png")!)
        default:
            ""
        }
        
    }
}

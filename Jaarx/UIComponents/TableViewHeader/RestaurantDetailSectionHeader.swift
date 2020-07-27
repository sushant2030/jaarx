//
//  RestaurantDetailSectionHeader.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RestaurantDetailSectionHeader: UIView {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    class func instanceFromNib() -> RestaurantDetailSectionHeader {
        return UINib(nibName: "RestaurantDetailSectionHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RestaurantDetailSectionHeader
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

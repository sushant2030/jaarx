//
//  RatingContainerView.swift
//  Jaarx
//
//  Created by Sumit Kumar on 21/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RatingContainerView: UIView {
    var ratingLabel: UILabel!
    
    // init from code
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    // init from xib or storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    // common setUp code
    private func setUpView(){
        configureRatingContainerView()
    }
    func configureRatingContainerView(){
        self.dropShadow()
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        self.backgroundColor = #colorLiteral(red: 0.4193069339, green: 0.9782986045, blue: 0, alpha: 1)
        self.addRatingLabel()
    }
    func addRatingLabel()  {
        ratingLabel = UILabel()
        ratingLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ratingLabel.font = UIFont.init(name: "VeradanaBold", size: 15.0)
        ratingLabel.text = defaultRating
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ratingLabel)
        ratingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

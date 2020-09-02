//
//  AccountHeaderView.swift
//  Jaarx
//
//  Created by Sumit Kumar on 31/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class AccountHeaderView: UIView {

   @IBOutlet weak var visitedPlacesButton: UIButton!
    @IBOutlet weak var visitedPlaceHighlightView: UIView!
    @IBOutlet weak var likedPlaceHighlightView: UIView!
    @IBOutlet weak var likedPlacesButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var settingHighlightView: UIView!
    var buttonAction: ((UIButton) -> Void)?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likedPlaceButtonAction(_ sender: UIButton) {
        self.hightLightSelectedViewWithTag(tag: sender.tag)
        self.buttonAction?(sender)
    }
    @IBAction func visitedPlaceButtonAction(_ sender: UIButton) {
        self.hightLightSelectedViewWithTag(tag: sender.tag)
        self.buttonAction?(sender)
    }
    
    @IBAction func settingButtonAction(_ sender: UIButton) {
        self.hightLightSelectedViewWithTag(tag: sender.tag)
        self.buttonAction?(sender)
    }
    func hightLightSelectedViewWithTag(tag:Int)  {
        switch tag {
        case 1:
            self.likedPlaceHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.visitedPlaceHighlightView.backgroundColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
            self.settingHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case 2:
            self.likedPlaceHighlightView.backgroundColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
            self.visitedPlaceHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.settingHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case 3:
            self.likedPlaceHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.visitedPlaceHighlightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.settingHighlightView.backgroundColor = #colorLiteral(red: 0, green: 0.6196078431, blue: 0.9921568627, alpha: 1)
         default:
            break
        }
    }

}

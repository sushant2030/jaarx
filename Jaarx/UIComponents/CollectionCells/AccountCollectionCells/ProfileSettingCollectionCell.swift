//
//  ProfileSettingCollectionCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 31/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class ProfileSettingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.phoneNumberTextField.text = UserDataSource.sharedInstance.user.phoneNumber
        self.emailTextField.text = UserDataSource.sharedInstance.user.email
        self.firstNameTextField.text = UserDataSource.sharedInstance.user.firstName
        self.lastNameTextField.text = UserDataSource.sharedInstance.user.lastName
    }

}

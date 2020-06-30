//
//  LoginVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 28/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit
import TextFieldEffects

class LoginVC: UIViewController {
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var splashImageView: UIImageView!
    @IBOutlet weak var btnOtp: UIButton!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tfMobile: AkiraTextField!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOtp.makeCornerRadiusWithRadi(radius: 15.0)
        containerView.makeViewCornerRadiusWithRadi(radius: 15.0)
        tfMobile.borderColor = .clear
        // Do any additional setup after loading the view.
    }
    
// MARK: - IBActions
    @IBAction func actionOTP(_ sender: UIButton) {
        
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        let signUpVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "SignUpVC")
        self.present(signUpVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

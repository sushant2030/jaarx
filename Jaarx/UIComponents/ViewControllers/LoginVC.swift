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
    @IBOutlet weak var lblSignup: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOtp.makeCornerRadiusWithRadi(radius: 15.0)
        containerView.makeViewCornerRadiusWithRadi(radius: 15.0)
        tfMobile.borderColor = .clear
        containerView.dropShadow()
        tfMobile.delegate = self
        containerView.backgroundColor = .white
        lblSignup.textColor = .white
        // Do any additional setup after loading the view.
    }
    
// MARK: - IBActions
    @IBAction func actionOTP(_ sender: UIButton) {
        APIClient.signInWithPhoneNumber(user: User()) { (response) in
            print(response)
            let user = User()
            switch response {
            case .success(let tokenDetails):
                user.token = tokenDetails.userTokenData?.token ?? ""
                user.user_id = tokenDetails.userTokenData?.userId ?? ""
                UserDataSource.sharedInstance.setUser(user: user)
                UserDataSource.sharedInstance.getUserDetails { (isSuccess) in
                    if isSuccess {
                        if let tabBarVC = UIStoryboard.tabBarVC(){
                            self.view.window?.rootViewController = tabBarVC
                        }
                    } else {
                        //SHOW ERROR
                    }
                }
                
            case .failure(_):
                print("Some Went Wrong")
            }
            
            
            
        }

        
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        if let signUpVC = UIStoryboard.signUpVC(){
        self.present(signUpVC, animated: true, completion: nil)
        }
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

extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

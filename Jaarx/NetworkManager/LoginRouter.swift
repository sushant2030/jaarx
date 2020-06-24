//
//  LoginRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 13/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

enum LoginRouter {
    case signIn(phoneNumber : String, otp : String, device_token : String)
    case signUp(phoneNumber : String, otp : String, device_token : String, device_os : String, firstName : String, lastName : String, email : String)
    case requestOTP(phoneNumber : String , countrycode : String)
}

extension LoginRouter : APIRouter {
    
    var parameters: Parameters? {
        switch self {
        case .signIn(let phoneNumber, let otp,let device_token):
            return [Constants.LoginAPIParameter.phoneNumber : phoneNumber, Constants.LoginAPIParameter.otp : otp, Constants.LoginAPIParameter.deviceToken : device_token]
        case .signUp(let phoneNumber,let otp,let device_token,let device_os,let firstName, let lastName,let email):
            return [Constants.LoginAPIParameter.phoneNumber : phoneNumber, Constants.LoginAPIParameter.otp : otp, Constants.LoginAPIParameter.deviceToken : device_token, Constants.LoginAPIParameter.deviceOS : device_os, Constants.LoginAPIParameter.firstName : firstName, Constants.LoginAPIParameter.lastName : lastName, Constants.LoginAPIParameter.email : email]
        case .requestOTP(let phoneNumber,let countrycode):
            return [Constants.LoginAPIParameter.phoneNumber:phoneNumber,Constants.LoginAPIParameter.countryCode:countrycode]
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/user/signin"
        case .signUp:
            return "/user/signup"
        case .requestOTP:
            return "/user/requestOTP"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }

}

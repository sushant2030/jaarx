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
        return["":""]
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

//
//  UserRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 13/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter {
    case userDetails(userId : String)
    case getOrder(userId : String)
    case getBookingRequests(user_id : String)
}

extension UserRouter : APIRouter {
    
    var path: String {
        switch self {
        case .userDetails:
            return "/user/user_details"
        case .getOrder:
            return "/user/getOrders?"
        case .getBookingRequests:
            return "/book/user_requests"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }

    
    var parameters: Parameters? {
        switch self {
        case .userDetails(let userId):
            return [Constants.UserAPIParameter.userId : userId]
        case .getOrder(let userId):
            return [Constants.UserAPIParameter.userId : userId]
        case .getBookingRequests(let user_id):
            return [Constants.UserAPIParameter.user_id:user_id]
        }
        
    }
    
    var url: URL {
        switch httpMethod {
        case .get:
            var parameterString : String?
            if (parameters != nil) {
                parameterString = Helper.makeUrlWithParameters(parameters!)
            }
            return URL.init(string: self.baseURL + self.path + (parameterString ?? ""))!
        default:
            return URL.init(string: self.baseURL + self.path)!
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest.init(url: self.url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    
}
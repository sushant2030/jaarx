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
    case addOrder(params : [String:Any])
    case registerDevice(params : [String:Any])
    case getCartDetails(userId:String)
    case getOrderDetails(orderId : Int)
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
        case .addOrder:
            return "/order/add"
        case .registerDevice:
            return "/device/register_device"
        case .getCartDetails:
            return "/cart/get"
        case .getOrderDetails:
            return "/order/get"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addOrder:
            return .post
        case .registerDevice:
            return .post
        default:
            return .get
        }
    }

    
    var parameters: Parameters? {
        switch self {
        case .userDetails(let userId):
            return [Constants.UserAPIParameter.user_id : userId]
        case .getOrder(let userId):
            return [Constants.UserAPIParameter.userId : userId]
        case .getBookingRequests(let user_id):
            return [Constants.UserAPIParameter.user_id:user_id]
        case .addOrder(let param):
            return param
        case .registerDevice(let param):
            return param
        case .getCartDetails(let userId):
            return [Constants.UserAPIParameter.userId : userId]
        case .getOrderDetails(let orderId):
            return [Constants.RestaurantAPIParameter.orderId : orderId]
        }
        
    }
    
    
}

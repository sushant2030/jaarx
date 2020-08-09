//
//  RestaurantRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 13/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

enum RestaurantRouter {
    case add(id : Int)
    case getFavorites(userId : String)
    case addReviews(resId : String , review : String)
    case setFavorite(userId : String, resId : String , status : Bool)
    case bookTableWith(params : [String:Any])
    case updateBookingWith(params : [String:Any])
    case getRestaurantDetailFor(id : String)
}

extension RestaurantRouter : APIRouter {
    
    var path: String {
        switch self {
        case .add:
            return "order/add"
        case .getFavorites:
            return "/restaurant/favorites"
        case .addReviews:
            return ""
        case .setFavorite:
            return "/restaurant/restaurant_favorite"
        case .bookTableWith:
            return "/book/table"
        case .updateBookingWith:
            return "/book/update"
        case .getRestaurantDetailFor:
            return "/user/restaurantDetails?"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getFavorites:
            return .get
        case .getRestaurantDetailFor:
            return .get
        default:
            return .post
        }
    }
    
    
    var parameters: Parameters? {
        switch self {
        case .add(let id):
            return [Constants.RestaurantAPIParameter.id : id]
        case .getFavorites(let userId):
            return [Constants.RestaurantAPIParameter.userId : userId]
        case .setFavorite(let userId,let resId,let status):
            return [Constants.RestaurantAPIParameter.userId : userId, Constants.RestaurantAPIParameter.resId : resId, Constants.RestaurantAPIParameter.status:status]
        case .bookTableWith(let params):
            return params
        case .updateBookingWith(let params):
            return params
        case .getRestaurantDetailFor(let id):
            return [Constants.RestaurantAPIParameter.id : id]
        default:
            return nil
        }
    }
    
}

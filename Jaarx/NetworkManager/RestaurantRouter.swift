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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getFavorites:
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
        default:
            return nil
        }
    }
    
}

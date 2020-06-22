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
    case getFavorites(user_id : String)
    case addReviews(res_id : String , review : String)
    case setFavorite(user_id : String, res_id : String , status : Bool)
    
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
        case .getFavorites(let user_id):
            return [Constants.RestaurantAPIParameter.userId : user_id]
        default:
            return nil
        }
    }
    
    var url: URL {
        return URL.init(string: self.baseURL + self.path)!
    }
    
    func asURLRequest() throws -> URLRequest {
        return URLRequest.init(url: self.url)
    }
    
    
}

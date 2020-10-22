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
    case addCart(params : [String:Any])
    case addOrder(params : [String:Any])
    case getFavorites(userId : String)
    case addReviews(resId : String , review : String)
    case setFavorite(userId : String, resId : String , status : Bool)
    case bookTableWith(params : [String:Any])
    case updateBookingWith(params : [String:Any])
    case getRestaurantDetailFor(id : String)
    case getMenu(id : String)
}

extension RestaurantRouter : APIRouter {
    
    var path: String {
        switch self {
        case .add:
            return "order/add"
        case .addCart:
            return "/cart/add_bulk"
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
            return "/user/restaurantDetails"
        case .getMenu:
            return "/menu/items"
        case .addOrder:
            return "/order/add"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getFavorites,.getRestaurantDetailFor,.getMenu:
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
        case .getMenu(let id):
            return [Constants.RestaurantAPIParameter.restaurantId : id]
        case .addCart(let params):
            return params
        case .addOrder(let params):
            return params
        default:
            return nil
        }
    }
    
    func asOrderURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest.init(url: self.url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.headers = headers!
        if httpMethod == .post {
            if let parameters = parameters, parameters.count > 0 {
                if let jsonObject = parameters.jsonData() {
                    urlRequest.httpBody = jsonObject
                }
            }
        }
        return urlRequest
    }
    
}

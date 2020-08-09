//
//  FavoriteRestaurant.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
struct FavoriteRestaurant : Codable {
    let code : Int?
    let message : String?
    let favoriteData : FavoriteData
    
}

struct FavoriteData : Codable {
    let id:String
    let userId:String
    let resId:String
    let restaurantDetails : [RestaurantDetail]
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case resId = "res_id"
        case restaurantDetails = "restaurant_details"
    }
}

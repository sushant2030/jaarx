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

struct FavoriteRestaurantList : Codable {
    let code : Int?
    let message : String?
    let favoriteData : [FavoriteRest]?
}

struct FavoriteRest : Codable {
    let id:String?
    let userId:String?
    let resId:String?
    let favRestaurant : FavRestaurant
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case resId = "res_id"
        case favRestaurant = "restaurant_details"
    }
}

struct FavRestaurant : Codable {
    let resId:String?
    let resName:String?
    let resAddress:String?
    let resRating:String?
    let resLocation:String?
    let resImageDetails:[ImageDetail]?
    
    enum CodingKeys: String, CodingKey {
        case resId = "res_id"
        case resName = "res_name"
        case resAddress = "res_address"
        case resRating = "res_rating"
        case resLocation = "res_location"
        case resImageDetails = "image_details"
    }
}

//
//  HomeResponse.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct  HomeResponse : Codable {
    let status : Int?
    let data : [HomeData]?
}

struct HomeData : Codable {
    let imageUrl : String?
    let type : String?
    let description : String?
    let title : String?
    let data : [RestaurantData]?
}

struct  RestaurantData : Codable {
    let categoryColor : String?
    let categoryId : String?
    let categoryName : String?
    let restaurantId : String?
    let restaurantName : String?
    let restaurantLocation : String?
    let restaurantCategories : [RestaurantCategory]?
    let imageDetails : [ImageDetail]?
    
    enum CodingKeys: String, CodingKey {
        case categoryColor = "res_category_color"
        case categoryId = "res_category_id"
        case categoryName = "res_category_name"
        case restaurantId = "res_id"
        case restaurantName = "res_name"
        case restaurantLocation = "res_location"
        case restaurantCategories = "restaurant_categories"
        case imageDetails = "image_details"
    }
    
}

struct ImageDetail : Codable {
    let imageId :String?
    let imageUrl : String?
    let restaurantId : String?
    
    enum CodingKeys : String, CodingKey {
        case imageId = "image_id"
        case imageUrl = "image_url"
        case restaurantId = "res_id"
    }
}



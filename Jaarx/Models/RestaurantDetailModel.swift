//
//  RestaurantDetailModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct  RestaurantDetailResponse : Codable {
    let code : Int?
    let message : String?
    let restaurantData : RestaurantDetail?
}

struct RestaurantDetail : Codable {
    let resId : String?
    let resName : String?
    let resAddress:String?
    let resLatitude:String?
    let resLongitude:String?
    let resOpenTime:String?
    let resCloseTime:String?
    let resInaugrated:String?
    let resRating : String?
    let resOpenDays : String?
    let resCloseDays : String?
    let resCity : String?
    let resLocation : String?
    let resDescription : String?
    let resAverageCost : String?
    let resServiceCharge : String?
    let resThumnailImage : String?
    let resImageDetails : [ImageDetail]?
    let resReviews : [Review]?
    let resCategories : [RestaurantCategory]?
    let resScanText : RestaurantText?
    let resReserveText : RestaurantText?
    
    enum CodingKeys: String, CodingKey {
        case resId = "res_id"
        case resName = "res_name"
        case resAddress = "res_address"
        case resLatitude = "res_latitude"
        case resLongitude = "res_longitude"
        case resOpenTime = "res_open_time"
        case resCloseTime = "res_close_time"
        case resInaugrated = "res_inaugurated"
        case resRating = "res_rating"
        case resOpenDays = "res_open_days"
        case resCloseDays = "res_close_days"
        case resCity = "res_city"
        case resLocation = "res_location"
        case resDescription = "res_description"
        case resAverageCost = "res_average_cost"
        case resServiceCharge = "service_charge"
        case resThumnailImage = "thumbnail_img"
        case resImageDetails = "image_details"
        case resReviews = "reviews"
        case resCategories = "restaurant_categories"
        case resScanText = "scanText"
        case resReserveText = "reserveText"
    }
}

struct RestaurantCategory : Codable {
    let isHashtag : String?
    let restaurantCategoryColor : String?
    let restaurantCategoryId : String?
    let restaurantCategoryName : String?
    
    enum CodingKeys : String, CodingKey {
        case isHashtag = "is_hashtag"
        case restaurantCategoryColor = "res_category_color"
        case restaurantCategoryId = "res_category_id"
        case restaurantCategoryName = "res_category_name"
    }
}

struct RestaurantText : Codable {
    let title : String?
    let description : String?
}
struct Review : Codable {
    let reviews : String?
}

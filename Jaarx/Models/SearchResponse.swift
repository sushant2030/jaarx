//
//  SearchResponse.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct SearchReponse : Codable {
    let code:String?
    let searchData:[SearchRestaurantData]?
}

struct SearchRestaurantData : Codable {
    let restaurantId : String!
    let restaurantName : String!
    let restaurantLocation : String?
    let type : String!
    let typeId : Int!
    
    enum CodingKeys: String, CodingKey {

        case restaurantId = "id"
        case restaurantName = "restaurant_name"
        case restaurantLocation = "location"
        case type = "type"
        case typeId = "type_id"
    }
    
}

//
//  MenuResponse.swift
//  Jaarx
//
//  Created by Sushant Alone on 28/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct MenuResponse : Codable {
    let code : Int?
    let message : String?
    let menuData : [MenuData]?
    
}

struct MenuData : Codable {
    let menuId : String?
    let resId : String?
    let cuisineCategoryDetails : [CuisineCategoryDetails]?
    
    enum CodingKeys: String, CodingKey {
        case menuId = "menu_id"
        case resId  = "res_id"
        case cuisineCategoryDetails = "cuisine_category_details"
    }
}

struct CuisineCategoryDetails : Codable, RowViewModel {
    let cuisineCategoryId : String?
    let cuisineCategoryName : String?
    let cuisineSection : String?
    let menuId : String?
    let foodDetails : [FoodDetails]?
    
    enum CodingKeys: String, CodingKey {
        case cuisineCategoryId = "cuisine_category_id"
        case cuisineCategoryName = "cuisine_category_name"
        case cuisineSection = "cuisine_section"
        case menuId = "menu_id"
        case foodDetails = "food_details"
    }
}

class FoodDetails : Codable , RowViewModel {
    let foodId : String?
    let resId : String?
    let dishName : String?
    let dishDescription : String?
    let dishPrice : String?
    let cuisineCategoryId : String?
    var quantity : String?
    let quantityDescription : String?
    let vegan : Bool?
    let foodImage : String?
    var cartQuantity = 0
    
    func getImageUrl() ->URL?{
        if let image = self.foodImage {
            return URL.init(string:image)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {

        case foodId = "food_id"
        case resId = "res_id"
        case dishName = "dish_name"
        case dishDescription = "dish_description"
        case dishPrice = "dish_price"
        case cuisineCategoryId = "cuisine_category_id"
        case quantity = "quantity"
        case quantityDescription = "quantity_description"
        case vegan = "vegan"
        case foodImage = "food_image"
    }
}



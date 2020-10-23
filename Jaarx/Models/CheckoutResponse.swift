//
//  CartCheckoutResponse.swift
//  Jaarx
//
//  Created by Sushant Alone on 21/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct CartCheckoutResponse : Codable {
    let code : String?
    let message : String?
    let response : CartAmountDetails?
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message  = "message"
        case response = "response"
    }
}



struct CartAmountDetails : Codable {
    let cartId : String?
    let resId : String?
    let userId : String?
    let priceBeforeTax : String?
    let cgstTax : String?
    let sgstTax : String?
    let serviceCharge : String?
    let totalPrice : String?
    let cartFoodDetails : [CartFoodDetails]?
    enum CodingKeys: String, CodingKey {
        case cartId = "cart_id"
        case resId  = "res_id"
        case userId = "user_id"
        case priceBeforeTax = "price_before_tax"
        case cgstTax = "cgst_tax"
        case sgstTax = "sgst_tax"
        case serviceCharge = "service_charge"
        case totalPrice = "total_price"
        case cartFoodDetails = "cart_food_details"
    }
}

struct CartFoodDetails : Codable {
    let cartFoodId : String?
    let foodId : String?
    let cartId : String?
    let quantity : String?
    let foodDetails : FoodDetails?
    enum CodingKeys: String, CodingKey {
        case cartFoodId = "cartFood_id"
        case foodId  = "food_id"
        case cartId = "cart_id"
        case quantity = "quantity"
        case foodDetails = "food_details"
    }
}

struct OrderCheckoutResponse : Codable {
    let code : Int?
    let message : String?
    let response : OrderAmountDetails?
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message  = "message"
        case response = "response"
    }
}

struct OrderFoodDetails : Codable {
    let orderFoodId : String?
    let foodId : String?
    let cartId : String?
    let quantity : String?
    let status : String?
    let foodDetails : FoodDetails?
    
    enum CodingKeys: String, CodingKey {
        case orderFoodId = "orderFood_id"
        case foodId  = "food_id"
        case cartId = "cart_id"
        case quantity = "quantity"
        case foodDetails = "food_details"
        case status = "status"
    }
}

struct OrderAmountDetails : Codable {
    let orderId : String?
    let resId : String?
    let userId : String?
    let priceBeforeTax : String?
    let cgstTax : String?
    let sgstTax : String?
    let serviceCharge : String?
    let totalPrice : String?
    let paymentStatus : String?
    let orderFoodDetails : [OrderFoodDetails]?
    let orderStatus : String?
    let orderDateTime : String?
    let restaurantDetails : RestaurantData?
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case resId  = "res_id"
        case userId = "user_id"
        case priceBeforeTax = "price_before_tax"
        case cgstTax = "cgst_tax"
        case sgstTax = "sgst_tax"
        case serviceCharge = "service_charge"
        case totalPrice = "total_price"
        case orderFoodDetails = "order_food_details"
        case paymentStatus = "payment_status"
        case orderStatus = "status"
        case orderDateTime = "order_date_time"
        case restaurantDetails = "restaurant_details"

    }
}

//
//  CartDataSource.swift
//  Jaarx
//
//  Created by Sushant Alone on 30/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

class Cart : RowViewModel {
    let foodId : Int?
    var quantity : Int?
    let dishName : String?
    let description : String?
    let price : Int?
    
    init(withFoodId foodId:Int, quantity : Int?, dishName : String, description : String?, price : String) {
        self.foodId = foodId
        self.quantity = quantity
        self.dishName = dishName
        self.description = description ?? ""
        self.price = Int(price)
    }
}

class CartDataSource {
    static var sharedCart = CartDataSource()
    
    var carts = Observable<[FoodDetails]> (value: [])
    
    func addCart() {
        
        var fooditemsArray = [[String:Int]]()
        var fooodId = 1006
        carts.value.map({
            var fooditems = [String:Int]()
            fooodId += 1
            fooditems["food_id"] = fooodId
            fooditems["cart_id"] = 1004
            fooditems["quantity"] = $0.cartQuantity
            fooditemsArray.append(fooditems)
        })
        let foodItemDict = ["fooditems":fooditemsArray]
        APIClient.addCartForRestaurantWithDetail(foodItems: foodItemDict) { (response) in
            print(response)
        }
    }
    
//    func destroy()  {
//        CartDataSource.sharedCart = nil
//    }
    
}

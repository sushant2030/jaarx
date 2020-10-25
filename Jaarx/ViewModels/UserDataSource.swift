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
//    "resId_tableNo"
    init(withFoodId foodId:Int, quantity : Int?, dishName : String, description : String?, price : String) {
        self.foodId = foodId
        self.quantity = quantity
        self.dishName = dishName
        self.description = description ?? ""
        self.price = Int(price)
    }
}

class CashDetails {
    var total : String?
    var sub : String?
    var gst : String?
    var discount : String?
    init(withTotal total:String, gst:String, discount : String, sub : String) {
        self.total = total
        self.gst = gst
        self.discount = discount
        self.sub = sub
    }
}

class UserDataSource {
    static var sharedInstance = UserDataSource()
    var cashDetails : CashDetails? 
    var user : User!
    var carts = Observable<[FoodDetails]> (value: [])
    var userFlow : UserFlow = .none
    var cartUpdated = Observable<Bool> (value: false)
    func setUser(user : User) {
        self.user = user
    }
    var transactionStatus : TransactionStatus! = .noTransaction
    
    func getUserDetails(completion : @escaping ((Bool) -> Void)) {
        APIClient.getUserDetails { [unowned self] (response) in
            switch response{
            case .success(let data):
                self.user.cartId = data.userData?.cartDetails?.cartId ?? ""
                completion(true)
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func addCart(completion : @escaping ((Bool) -> Void)) {
        
        var fooditemsArray = [[String:Any]]()
        _ = carts.value.map({
            var fooditems = [String:Any]()
            fooditems["food_id"] = $0.foodId
            fooditems["cart_id"] = user.cartId
            fooditems["quantity"] = $0.cartQuantity
            fooditemsArray.append(fooditems)
        })
        let foodItemDict = ["fooditems":fooditemsArray]
        print(foodItemDict)
        APIClient.addCartForRestaurantWithDetail(foodItems: foodItemDict) {  (response) in
            switch response {
            case .success(let responseData):
                if !(responseData.message?.contains("not"))!{
                    completion(true)
                } else {
                completion(false)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func addOrder(completion : @escaping ((Bool) -> Void)) {
        
        var fooditemsArray = [[String:Any]]()
        _ = carts.value.map({
            var fooditems = [String:Any]()
            fooditems["food_id"] = $0.foodId
            fooditems["quantity"] = $0.cartQuantity
            fooditemsArray.append(fooditems)
        })
        var foodItemDict : [String:Any]?
        if let orderId = user.orderId  {
            foodItemDict = ["food_items":fooditemsArray,"user_id" : user.user_id, "table_id" : user.tableId, "order_id" : orderId]
        } else {
            foodItemDict = ["food_items":fooditemsArray,"user_id" : user.user_id, "table_id" : user.tableId]
        }
            
        if let foodItemParam = foodItemDict {
            APIClient.addOrderForRestaurantWithDetail(foodItems: foodItemParam) { (response) in
                switch response {
                case .success(let responseData):
                    if !(responseData.message?.contains("not"))!{
                        UserDataSource.sharedInstance.user.orderId = responseData.order_id
                        completion(true)
                    } else {
                    completion(false)
                    }
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
        
    }
}

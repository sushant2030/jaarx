//
//  OrderHubViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

class OrderHubViewModel {
    let orderNo = Observable<String> (value: "")
    var pendingFoodData = Observable<[CartFoodVM]> (value: [])
    var servedFoodData = Observable<[CartFoodVM]> (value: [])
    let totalCost = Observable<String> (value: "")
    let restaurantName = Observable<String> (value: "")
    let restaurantLocation = Observable<String> (value: "")
    
    
    func getNumberOfSections() -> Int {
        if pendingFoodData.value.count > 0 , servedFoodData.value.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    func getOrderDetails()  {
        APIClient.getOrderDetails { (response) in
            switch response {
            case .success(let orderCheckoutResponse):
                self.totalCost.value = "₹\(orderCheckoutResponse.response?.totalPrice ?? "0.0")"
                self.restaurantName.value = orderCheckoutResponse.response?.restaurantDetails?.restaurantName ?? ""
                self.restaurantLocation.value = orderCheckoutResponse.response?.restaurantDetails?.restaurantLocation ?? ""
                self.parseOrderDetails(orderFoodDetails: orderCheckoutResponse.response?.orderFoodDetails ?? [])
                self.orderNo.value = orderCheckoutResponse.response?.orderId ?? ""
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parseOrderDetails(orderFoodDetails : [OrderFoodDetails])  {
        for cartFood in orderFoodDetails {
            let quantity = cartFood.quantity ?? "1"
            let dishName = cartFood.foodDetails?.dishName ?? ""
            let price = cartFood.foodDetails?.dishPrice ?? "0"
            let totalPrice = "\(Int(price)! * Int(quantity)!)"
            let orderFood = CartFoodVM.init(withCartDetails: dishName, originalPrice: price, totalPrice: totalPrice, quantity: quantity,foodStatus: cartFood.foodDetails?.status ?? "pending", isVeg: cartFood.foodDetails?.vegan ?? true)
            orderFood.foodStatus = cartFood.foodDetails?.status ?? ""
            if let foodStatus = orderFood.foodStatus {
                if foodStatus == "delivered" {
                    servedFoodData.value.append(orderFood)
                } else {
                    pendingFoodData.value.append(orderFood)
                }
            }
            
        }
    }
}



//
//  CheckoutVM.swift
//  Jaarx
//
//  Created by Sushant Alone on 21/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

class CheckoutVM {
    
    var userFlow : UserFlow = .preOrder
    var subTotal = Observable<String> (value : "loading..." )
    var offerDiscount = Observable<String> (value: "loading...")
    var gst = Observable<String> (value: "loading...")
    var total = Observable<String> (value: "loading...")
    var orderNo = Observable<String> (value: "")
    var foodData = Observable<[CartFoodVM]> (value: [])
    var paymentMode = Observable<PaymentMode> (value : .cash)
    var paymentStatus = Observable<String> (value: "")
    
    func setUserFlow(withMode userFlow : UserFlow) {
        self.userFlow = userFlow
    }
    
    func getDetails() {
        if let _ = UserDataSource.sharedInstance.user.orderId {
            self.getOrderDetails()
        } else {
            switch userFlow {
            case .preOrder:
                self.getCartDetails()
            case .scan:
                self.getOrderDetails()
            default:
                print("")
            }
        }
    }
    
    func parseCartDetails(cartFoodDetails : [CartFoodDetails])  {
        for cartFood in cartFoodDetails {
            let quantity = cartFood.quantity ?? "1"
            let dishName = cartFood.foodDetails?.dishName ?? ""
            let price = cartFood.foodDetails?.dishPrice ?? "0"
            let totalPrice = "\(Int(price)! * Int(quantity)!)"
            let cartFood = CartFoodVM.init(withCartDetails: dishName, originalPrice: price, totalPrice: totalPrice, quantity: quantity, foodStatus: cartFood.foodDetails?.status ?? "", isVeg: cartFood.foodDetails?.vegan ?? true)
            foodData.value.append(cartFood)
        }
    }
    
    func parseOrderDetails(orderFoodDetails : [OrderFoodDetails])  {
        for cartFood in orderFoodDetails {
            let quantity = cartFood.quantity ?? "1"
            let dishName = cartFood.foodDetails?.dishName ?? ""
            let price = cartFood.foodDetails?.dishPrice ?? "0"
            let totalPrice = "\(Int(price)! * Int(quantity)!)"
            let orderFood = CartFoodVM.init(withCartDetails: dishName, originalPrice: price, totalPrice: totalPrice, quantity: quantity, foodStatus: cartFood.foodDetails?.status ?? "", isVeg: cartFood.foodDetails?.vegan ?? true)
            orderFood.foodStatus = cartFood.foodDetails?.status ?? ""
            foodData.value.append(orderFood)
        }
    }
    
    func getCartDetails()  {
        APIClient.getCartDetails { (response) in
            switch response {
            case .success(let CartCheckoutResponse):
                self.subTotal.value = CartCheckoutResponse.response?.priceBeforeTax ?? "0.0"
                self.offerDiscount.value = "0.0"
                let gst = CartCheckoutResponse.response?.cgstTax ?? "0.0"
                let sgst = CartCheckoutResponse.response?.sgstTax ?? "0.0"
                let serviceCharge = CartCheckoutResponse.response?.serviceCharge ?? "0.0"
                let total = Float(gst)! + Float(sgst)! + Float(serviceCharge)!
                self.gst.value = "\(total)"
                self.total.value = CartCheckoutResponse.response?.totalPrice ?? "0.0"
                self.parseCartDetails(cartFoodDetails: CartCheckoutResponse.response?.cartFoodDetails ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOrderDetails()  {
        APIClient.getOrderDetails { (response) in
            switch response {
            case .success(let orderCheckoutResponse):
                self.subTotal.value = orderCheckoutResponse.response?.priceBeforeTax ?? "0.0"
                self.offerDiscount.value = "0.0"
                let gst = orderCheckoutResponse.response?.cgstTax ?? "0.0"
                let sgst = orderCheckoutResponse.response?.sgstTax ?? "0.0"
                let serviceCharge = orderCheckoutResponse.response?.serviceCharge ?? "0.0"
                let total = Float(gst)! + Float(sgst)! + Float(serviceCharge)!
                self.gst.value = "\(total)"
                self.total.value = orderCheckoutResponse.response?.totalPrice ?? "0.0"
                self.paymentStatus.value = orderCheckoutResponse.response?.paymentStatus ?? ""
                UserDataSource.sharedInstance.cashDetails = CashDetails.init(withTotal: self.total.value, gst: self.gst.value, discount: "0.0",sub: self.subTotal.value)
                self.parseOrderDetails(orderFoodDetails: orderCheckoutResponse.response?.orderFoodDetails ?? [])
                self.orderNo.value = orderCheckoutResponse.response?.orderId ?? ""
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellIdentifier() -> String  {
        return OrderListCell.cellIdentifier()
    }
    
    func getHeightForRow() -> CGFloat {
        return 60
    }
}


class CartFoodVM : RowViewModel {
    let dishName : String?
    let originalPrice : String?
    let totalPrice : String?
    let quantity : String?
    var foodStatus : String?
    let isVeg : Bool?
    init(withCartDetails dishName:String, originalPrice : String, totalPrice : String, quantity : String, foodStatus : String, isVeg : Bool) {
        self.dishName = dishName
        self.originalPrice = originalPrice
        self.totalPrice = totalPrice
        self.quantity = quantity
        self.foodStatus = foodStatus
        self.isVeg = isVeg
    }
}

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
    
    func setUserFlow(withMode userFlow : UserFlow) {
        self.userFlow = userFlow
    }
    
    func getDetails() {
        switch userFlow {
        case .preOrder:
            self.getCartDetails()
        default:
            self.getOrderDetails()
        }
    }
    
    func parseCartDetails(cartFoodDetails : [CartFoodDetails])  {
        for cartFood in cartFoodDetails {
            let quantity = cartFood.quantity ?? "1"
            let dishName = cartFood.foodDetails?.dishName ?? ""
            let price = cartFood.foodDetails?.dishPrice ?? "0"
            let totalPrice = "\(Int(price)! * Int(quantity)!)"
            let cartFood = CartFoodVM.init(withCartDetails: dishName, originalPrice: price, totalPrice: totalPrice, quantity: quantity)
            foodData.value.append(cartFood)
        }
    }
    
    func parseOrderDetails(orderFoodDetails : [OrderFoodDetails])  {
        for cartFood in orderFoodDetails {
            let quantity = cartFood.quantity ?? "1"
            let dishName = cartFood.foodDetails?.dishName ?? ""
            let price = cartFood.foodDetails?.dishPrice ?? "0"
            let totalPrice = "\(Int(price)! * Int(quantity)!)"
            let orderFood = CartFoodVM.init(withCartDetails: dishName, originalPrice: price, totalPrice: totalPrice, quantity: quantity)
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
    var foodStatus : String? = nil
    init(withCartDetails dishName:String, originalPrice : String, totalPrice : String, quantity : String) {
        self.dishName = dishName
        self.originalPrice = originalPrice
        self.totalPrice = totalPrice
        self.quantity = quantity
    }
}

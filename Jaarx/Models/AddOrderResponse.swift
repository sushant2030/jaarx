//
//  AddOrderResponse.swift
//  Jaarx
//
//  Created by Sumit Kumar on 23/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct  AddOrderResponse : Codable{
    
    let message : String?
    let orderId : Int?
    
    enum CodingKeys: String, CodingKey {
    case message = "message"
    case orderId = "order_id"
    }
    
}

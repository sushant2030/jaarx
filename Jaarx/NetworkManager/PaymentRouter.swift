//
//  PaymentRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 26/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire
// http://localhost:9444/payment/pay?user_id=81952a9e-7016-4e58-9e43-d4bb0900ee91


enum PaymentRouter {
    case preorder
    case scan
}

extension PaymentRouter : APIRouter {
    var path: String {
        return "/payment/pay"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .preorder:
            return ["user_id" : UserDataSource.sharedInstance.user.user_id]
        case .scan:
            return ["user_id" : UserDataSource.sharedInstance.user.user_id, "order_id" : 284]
                
//            ?UserDataSource.sharedInstance.user.orderId ?? 0]
        }
    }
    
    
}

//
//  HomeRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 13/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire


enum HomeRouter {
    case home
    case seeMore(type : String)
}

extension HomeRouter : APIRouter {
    
    var path: String {
        switch self {
        case .seeMore:
            return "/user/seeMore"
        default:
            return "/user/home"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .seeMore(let type):
            return [Constants.HomeAPIParameter.type : type]
        default:
            return nil
        }
    }
    
    var url: URL {
        if let urlPath = URL.init(string: baseURL + path){
            return urlPath
        } else {
            return URL(fileURLWithPath: "")
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest.init(url: self.url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Parameters
        return urlRequest
    }
    
    
}

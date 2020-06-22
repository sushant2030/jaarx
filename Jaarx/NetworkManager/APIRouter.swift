//
//  APIRouter.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}

extension APIRouter {
    var baseURL: String {
        return "http://ec2-3-134-99-218.us-east-2.compute.amazonaws.com:9444"
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var version: String {
        return ""
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

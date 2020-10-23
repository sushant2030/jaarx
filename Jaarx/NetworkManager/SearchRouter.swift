//
//  SearchRouter.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

enum SearchRouter {
    case search(searchText : String)
}

extension SearchRouter : APIRouter {
    var path: String {
        return "/search/item"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let searchText):
            return ["text" : searchText]

        }
    }
    
    
}

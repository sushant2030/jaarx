//
//  Constants.swift
//  Jaarx
//
//  Created by Sushant Alone on 14/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct LoginAPIParameter {
        static let phoneNumber = "phoneNumber"
        static let otp = "otp"
        static let deviceToken = "device_token"
        static let deviceOS = "device_os"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let countryCode = "countrycode"
    }
    struct RestaurantAPIParameter {
        static let id = "id"
        static let userId = "user_id"
        static let resId = "res_id"
        static let review = "review"
        static let status = "status"
    }
    struct UserAPIParameter{
        static let userId = "userId"
        static let user_id = "user_id"
    }
    struct HomeAPIParameter {
        static let type = "type"
    }
    
}

enum BucketType : String {
    case carousel       = "carousel"
    case banner         = "banner"
    case topPicks       = "topPicks"
    case critics        = "criticsFavourites"
    case mostscanned    = "mostScanned"
    case hotcuisins     = "hotCuisines"
    case hashtags       = "hashTags"
    case scanAndOrder   = "scanAndOrder"
    case newlyOpened    = "newlyOpened"
}

enum SearchResultType : String {
    case restaurant = "restaurant"
    case food = "food"
}

enum CellAction {
    case preOrder
    case scan
}
enum RestaurantDetailCellType {
    case ScanNOrder
    case ReserveNOrder
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
}

enum TimeMode : String {
    case am = "AM"
    case pm = "PM"
}


let baseUrlPath = "http://ec2-3-134-99-218.us-east-2.compute.amazonaws.com:9444"
let activityBackgroundViewTag = 475647

enum BucketCellHeight : CGFloat
{
    case small =  90.0
    case medium = 150.0
    case large = 250.0
}

let RestaurantDetailTextRowHeight = 114.0
let RestaurantDetailPickaBooRowHeight = 136.0
let RestaurantDetailRatingsRowHeight = 84.0
let RestaurantDetailHeaderHeight = 431.0
let RestaurantDetailSectionViewHeight = 70.0
let defaultRating = "4.2"

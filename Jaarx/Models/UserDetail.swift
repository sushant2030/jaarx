//
//  UserDetail.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

struct UserDetail : Codable {
    let message : String?
    let userData : UserData?
}

struct UserData : Codable {
    let userId : String?
    let userName : String?
    let userFirstName : String?
    let userLastName : String?
    let userPhoneNumber: String?
    let userEmail: String?
    let roleId: String?
    let resId: String?
    let cartDetails : CartDetails?
    let roleDetails : RoleDetails?
    
    enum CodingKeys : String, CodingKey {
        case userId = "user_id"
        case userName = "user_name"
        case userFirstName = "user_firstName"
        case userLastName = "user_lastName"
        case userPhoneNumber = "user_phoneNumber"
        case userEmail = "user_email"
        case roleId = "role_id"
        case resId = "res_id"
        case cartDetails = "cartDetails"
        case roleDetails = "role_details"
    }
    
}

struct RoleDetails : Codable {
    let roleName : String?
    enum CodingKeys : String, CodingKey {
        case roleName = "role_name"
    }
}

struct CartDetails : Codable {
    let cartId : String?
     enum CodingKeys : String, CodingKey {
        case cartId = "cart_id"
    }
}

struct Token : Codable {
    let message : String?
    let code : Int?
    let userTokenData : UserTokenData?
}

struct UserTokenData : Codable {
    let userId : String?
    let token : String?
    enum CodingKeys : String, CodingKey {
        case userId = "user_id"
        case token = "token"
    }
}

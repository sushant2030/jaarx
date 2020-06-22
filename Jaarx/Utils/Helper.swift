//
//  Helper.swift
//  Jaarx
//
//  Created by Sushant Alone on 15/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire

struct Helper {
    static func makeUrlWithParameters(_ parameters :Parameters) -> String {
        do {
                              
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
            print(dictFromJSON)
            let jsonString = dictFromJSON.reduce("") { "\($0)\($1.0)=\($1.1)&" }
                return jsonString
            } else {
                return ""
            }
                              
        } catch {
            return ""
        }
    }
    
    static func makeHttpBodyWithParameters(_ parameters:Parameters) -> Data? {
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
                print(dictFromJSON)
                let jsonString = dictFromJSON.reduce("") { "\($0)\($1.0)=\($1.1)&" }
                let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
                return jsonData
            } else {
                return nil
            }
            
        } catch {
            return nil
        }
    }
}

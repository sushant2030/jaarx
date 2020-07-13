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
            return jsonData
        } catch {
            return nil
        }
    }
    
    static func loadJson(filename fileName: String) -> [String:Any]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
               let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                          print(jsonResult)
                    return jsonResult
                }

            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension UIButton {
    func makeCornerRadiusWithRadi(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func makeViewCornerRadiusWithRadi(radius:CGFloat) {
           self.layer.cornerRadius = radius
           self.layer.masksToBounds = true
    }
}

extension UIImageView {
    func downloaded(from url: URL) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        let cache = URLCache.shared
        let request = URLRequest.init(url: url)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage.init(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data, let image = UIImage.init(data: data) {
                        let cachedData = CachedURLResponse.init(response: response!, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                             self.image = image
                        }
                    }
                }.resume()
            }
        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
    }
}


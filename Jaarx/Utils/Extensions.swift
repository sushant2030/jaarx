//
//  Extensions.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    static func orderStoryboard() -> UIStoryboard { return UIStoryboard(name: "Order", bundle: Bundle.main) }
    static func loginStoryboard() -> UIStoryboard { return UIStoryboard(name: "Login", bundle: Bundle.main) }
    static func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
    static func restaurantDetailVCWithRestaurant(id : String) -> RestaurantDetailVC? {
        let restaurantVC = mainStoryboard().instantiateViewController(withIdentifier: "RestaurantDetailVC") as? RestaurantDetailVC
        restaurantVC?.restaurantId = id
        return restaurantVC
    }
    static func tabBarVC() -> JMainTabbarVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "JMainTabbarVC") as? JMainTabbarVC
    }
    static func signUpVC() -> SignUpVC? {
        return loginStoryboard().instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
    }
    static func loginVC() -> LoginVC? {
        return loginStoryboard().instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    }
    static func qrCodeScannerVC() -> QRCodeScannerVC? {
        return orderStoryboard().instantiateViewController(withIdentifier: "QRCodeScannerVC") as? QRCodeScannerVC
    }
    static func preOrderVC() -> PreOrderVC? {
        return orderStoryboard().instantiateViewController(identifier: "PreOrderVC") as? PreOrderVC
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
    }
}

extension UIView{
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = activityBackgroundViewTag
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(activityBackgroundViewTag){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}

extension UITableViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}


//
//  HomeViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 02/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class HomeViewModel {
    var homeTableViewModel = Observable<[HomeRowVM]> (value: [])
    var isLoading = Observable<Bool> (value: true)
    
    func getHomeData()  {
        APIClient.getHomeData { (homeResponse) in
            switch homeResponse{
            case .success(let homeResponse):
                self.isLoading.value = false
                self.buildViewModels(response: homeResponse)
            case .failure(let error):
                self.isLoading.value = false
                print(error)
            }
        }
    }
    
    func buildViewModels(response:HomeResponse) {
        for homeData in response.data ?? [] {
            var homeBuckets = HomeRowVM.init(imageUrl: homeData.imageUrl, type: homeData.type, description: homeData.description, title: homeData.title ?? "", data: homeData.data)
            homeBuckets.bucketType = BucketType(rawValue: homeData.type ?? "banner") ?? .banner
            self.homeTableViewModel.value.append(homeBuckets)
        }
    }
    
}

struct HomeRowVM : RowViewModel{
    let imageUrl : String?
    let type : String?
    let description : String?
    let title : String?
    let data : [RestaurantData]?
    var  bucketTitleViewHeight : CGFloat{
        get{self.getBucketTitleViewHeight()}
    }
    var backgroundColor : UIColor {
        get{self.getBackgroundColor()}
    }
    var bucketType:BucketType?
    var rowHeight : CGFloat {
        get{self.getRowHeight()}
    }
    
    func getBackgroundColor() -> UIColor {
        let bgColor : UIColor
        switch self.bucketType{
        case .hotcuisins:
            bgColor = .blue
        default:
            bgColor = .red
        }
        return bgColor
    }
    func getBucketTitleViewHeight() -> CGFloat {
        var titleViewHeight = 0.0
        switch self.bucketType{
        case .banner,.carousel,.scanAndOrder:
            titleViewHeight = 0.0
        default:
            titleViewHeight = 50.0
        }
        return CGFloat(titleViewHeight)
    }
    func getRowHeight() -> CGFloat {
        var rowHeight = CGFloat(0.0)
        switch self.bucketType {
        case .carousel,.banner,.scanAndOrder,.hotcuisins:
            rowHeight = BucketCellHeight.medium.rawValue
        case .hashtags:
            rowHeight = BucketCellHeight.small.rawValue
        default:
            rowHeight = BucketCellHeight.large.rawValue
        }
        return rowHeight
    }
    
}

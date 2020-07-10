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

struct HomeViewModel {
    var homeData = Observable<[HomeBucketViewModel]> (value: [])
    
    func getHomeData()  {
        APIClient.getHomeData { (homeResponse) in
            switch homeResponse{
            case .success(let response):
                for homeData in response.data ?? [] {
                    var homeBuckets = HomeBucketViewModel.init(imageUrl: homeData.imageUrl, type: homeData.title, description: homeData.description, title: homeData.title, data: homeData.data)
                    homeBuckets.bucketType = BucketType(rawValue: homeData.type ?? "banner") ?? .banner
                    self.homeData.value.append(homeBuckets)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

struct HomeBucketViewModel : RowViewModel{
    let imageUrl : String?
    let type : String?
    let description : String?
    let title : String?
    let data : [RestaurantData]?
    var bucketType:BucketType = .banner
    
}

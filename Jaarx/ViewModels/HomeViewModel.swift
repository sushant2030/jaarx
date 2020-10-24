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
    var scanButtonPressed = Observable<RestaurantCellVM?>(value: nil)
    func getHomeData()  {
        APIClient.getHomeData {[weak self]  (homeResponse) in
            switch homeResponse{
            case .success(let homeResponse):
                self?.isLoading.value = false
                self?.buildViewModels(response: homeResponse)
            case .failure(let error):
                self?.isLoading.value = false
                print(error)
            }
        }
    }
    
    func buildViewModels(response:HomeResponse) {
        for homeData in response.data ?? [] {
            let restaurantCellVMs = buildRestaurantCellVMs(homeData.data)
            let bucketType = BucketType(rawValue: homeData.type ?? "banner") ?? .banner
            let restaurantViewModel = RestaurantViewModel.init(restaurantDataCollection : restaurantCellVMs,bucketType:bucketType)
            let homeRowVM = HomeRowVM.init(imageUrl: homeData.imageUrl, type: homeData.type, description: homeData.description, title: homeData.title ?? "", restaurantViewModel: restaurantViewModel,bucketType: bucketType)
            self.homeTableViewModel.value.append(homeRowVM)
        }
    }
    
    private func buildRestaurantCellVMs(_ restaurantArray:[RestaurantData]?) -> [RestaurantCellVM] {
        var restaurantCellVMArray = [RestaurantCellVM] ()
        for restaurant in restaurantArray ?? [] {
            let restaurantVM = RestaurantCellVM.init(restaurantId: restaurant.restaurantId, imageDetails: restaurant.imageDetails, location: restaurant.restaurantLocation ?? "", title: restaurant.restaurantName ?? "", categoryName: restaurant.categoryName, categoryColor: restaurant.categoryColor)
            restaurantCellVMArray.append(restaurantVM)
        }
        return restaurantCellVMArray
    }
}

class HomeRowVM : RowViewModel{
    let imageUrl : String?
    let type : String?
    let description : String?
    let title : String?
    let restaurantViewModel : RestaurantViewModel?
    var backgroundColor : UIColor {
        get{self.getBackgroundColor()}
    }
    var bucketType:BucketType?
    var rowHeight : CGFloat {
        get{self.getRowHeight()}
    }
    init(imageUrl: String?, type: String?, description: String?, title: String?, restaurantViewModel: RestaurantViewModel?,bucketType: BucketType?){
        self.imageUrl = imageUrl
        self.type = type
        self.description = description
        self.title = title
        self.restaurantViewModel = restaurantViewModel
        self.bucketType = bucketType
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

    func getRowHeight() -> CGFloat {
        var rowHeight = CGFloat(0.0)
        switch self.bucketType {
        case .carousel,.banner,.scanAndOrder,.hotcuisins:
            rowHeight = BucketCellHeight.medium.rawValue
            return rowHeight
        case .hashtags:
            if (restaurantViewModel?.restaurantCollectionVM.value.count == 0) {
                return 0.0
            }
            rowHeight = BucketCellHeight.small.rawValue
            return rowHeight
        default:
            rowHeight = BucketCellHeight.large.rawValue
            return rowHeight
        }
    }
    func cellIdentifier() -> String {
        var cellIdentifier : String
        switch self.bucketType {
        case .banner,.carousel,.scanAndOrder:
            cellIdentifier = CarouselTableCell.cellIdentifier()
        default:
            cellIdentifier = BucketCell.cellIdentifier()
        }
        return cellIdentifier
    }
    
}

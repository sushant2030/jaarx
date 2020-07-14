//
//  RestaurantViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

class RestaurantViewModel {
    var restaurantCollectionVM = [RestaurantCellVM]()
    var homeRowVM : RowViewModel?
    let bucketType:BucketType?
    var numberOfCells : Int?
    init(homeBucketVM:HomeRowVM) {
        self.bucketType = homeBucketVM.bucketType
        self.homeRowVM = homeBucketVM
        self.setNumberOfCellsForSection(homeBucketVM: homeBucketVM)
        self.buildViewModels(homeBucketVM: homeBucketVM)
    }
    private func buildViewModels(homeBucketVM:HomeRowVM) {
        for restaurantData in homeBucketVM.data ?? [] {
            let restaurantVM = RestaurantCellVM.init(imageDetails: restaurantData.imageDetails, location: restaurantData.restaurantLocation ?? "", title: restaurantData.restaurantName ?? "")
            self.restaurantCollectionVM.append(restaurantVM )
        }
    }
    private func setNumberOfCellsForSection (homeBucketVM:HomeRowVM)  {
        switch bucketType {
        case .carousel,.banner,.scanAndOrder:
            self.numberOfCells = 1
        default:
            self.numberOfCells = homeBucketVM.data?.count ?? 0
        }
    }
    func cellIdentifier() -> String {
        var cellIdentifier : String
        switch self.bucketType {
        case .banner,.carousel,.scanAndOrder:
            cellIdentifier = CarouselCell.cellIdentifier()
        case .critics,.mostscanned,.newlyOpened,.topPicks:
            cellIdentifier = LongCollectionCell.cellIdentifier()
        case .hotcuisins:
            cellIdentifier = SquareCollectionCell.cellIdentifier()
        case .hashtags:
            cellIdentifier = HorizontalListCollectionCell.cellIdentifier()
        default:
            cellIdentifier = LongCollectionCell.cellIdentifier()
        }
        return cellIdentifier
    }
    
}
struct RestaurantCellVM:RowViewModel {
    let imageDetails : [ImageDetail]?
    let location : String?
    let title : String?
    var imageUrl : URL? {
        get{self.getImageUrl()}
    }
    func getImageUrl() ->URL?{
        if let imageDetails = self.imageDetails,imageDetails.count > 0,let img = imageDetails[0].imageUrl{
            return URL.init(string:img)
        }
        return nil
    }
}


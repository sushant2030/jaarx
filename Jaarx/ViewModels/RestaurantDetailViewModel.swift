//
//  RestaurantDetailViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit
class RestaurantDetailViewModel{
    var sectionVMs = Observable<[SectionViewModel]> (value: [])
    var restaurantHeaderVM = Observable<HeaderViewModel?> (value: nil)
    var isLoading = Observable<Bool> (value: true)
    //TODO: Remove hard coded part from here
    let sectionTitles = ["","Picka Boo","In Words","CriticsScore"]
    init(restaurantId:String) {
        self.getRestaurantDetailFor(resId:restaurantId)
    }
    func getRestaurantDetailFor(resId : String) {
        //TODO: Set the correct resId, right now getting proper response for id 2 that's why hard coded
        APIClient.getRestaurantDetailFor(resId:"2") {[weak self] restaurantDetailResponse in
            switch restaurantDetailResponse{
            case .success(let restaurantDetailResponse):
                self?.isLoading.value = false
                if restaurantDetailResponse.code == 200{
                    if let restaurantDetail = restaurantDetailResponse.restaurantData{
                        self?.buildViewModels(restaurantDetail: restaurantDetail)
                    }
                }
            case .failure(_):
                self?.isLoading.value = false
            }
        }
    }
    
    func buildViewModels(restaurantDetail:RestaurantDetail)  {
        self.restaurantHeaderVM.value = self.buildHeaderViewModel(restaurantDetail: restaurantDetail)
        for sectionTitle in sectionTitles
        {
            switch sectionTitle {
            case "":
                self.sectionVMs.value.append(SectionViewModel.init(rowViewModels: self.buildRowModelForFirstSection(restaurantDetail: restaurantDetail), headerTitle: nil, headerViewModel: self.restaurantHeaderVM.value, sectionHeight: Float(RestaurantDetailHeaderHeight), rowHeightForSection:Float(RestaurantDetailTextRowHeight) ))
            case "Picka Boo":
                self.sectionVMs.value.append(SectionViewModel.init(rowViewModels:[RestaurantPickaBooVM.init(resImageDetails: restaurantDetail.resImageDetails)], headerTitle:sectionTitle, headerViewModel: nil, sectionHeight: Float(RestaurantDetailSectionViewHeight), rowHeightForSection: Float(RestaurantDetailPickaBooRowHeight)))
            case "In Words":
                self.sectionVMs.value.append(SectionViewModel.init(rowViewModels:[RestaurantInWordsVM.init(descriptionText: restaurantDetail.resDescription)], headerTitle: sectionTitle, headerViewModel: nil, sectionHeight: Float(RestaurantDetailSectionViewHeight), rowHeightForSection: Float(UITableView.automaticDimension)))
            case "CriticsScore":
                self.sectionVMs.value.append(SectionViewModel.init(rowViewModels: [RestaurantRatingVM.init(ratingArray: nil)], headerTitle: sectionTitle, headerViewModel: nil, sectionHeight: Float(RestaurantDetailSectionViewHeight), rowHeightForSection: Float(RestaurantDetailRatingsRowHeight)))
                //TODO: Get the proper and create VM and Cell
            default:
                break
            }
        }
        
    }
    func buildHeaderViewModel(restaurantDetail:RestaurantDetail) -> HeaderViewModel  {
        return HeaderViewModel.init(imageUrlString: restaurantDetail.resThumnailImage, rating: restaurantDetail.resRating, restaurantName: restaurantDetail.resName, restaurantLocation: restaurantDetail.resLocation, restaurantCity: restaurantDetail.resCity, openTime: restaurantDetail.resOpenTime,closeTime: restaurantDetail.resCloseTime, priceRangeText: restaurantDetail.resAverageCost, openDaysText: restaurantDetail.resOpenDays, resCategories: restaurantDetail.resCategories)
    }
    func buildRowModelForFirstSection(restaurantDetail:RestaurantDetail) -> [RestaurantTextVM] {
        var restaurantTextVMs = [RestaurantTextVM]()
        let restaurantScanTextVM = RestaurantTextVM.init(titleText: restaurantDetail.resScanText?.title, descriptionText: restaurantDetail.resScanText?.description, cellType: .ScanNOrder)
        restaurantTextVMs.append(restaurantScanTextVM)
        let restaurantReserveTextVM = RestaurantTextVM.init(titleText: restaurantDetail.resReserveText?.title, descriptionText: restaurantDetail.resReserveText?.description, cellType: .ReserveNOrder)
        restaurantTextVMs.append(restaurantReserveTextVM)
        return restaurantTextVMs
        
    }
    
    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is RestaurantTextVM:
            return RestaurantDetailTextCell.cellIdentifier()
        case is RestaurantPickaBooVM:
            return RestaurantPickaBooCell.cellIdentifier()
        case is RestaurantInWordsVM:
        return RestaurantInWordsCell.cellIdentifier()
        case is RestaurantRatingVM:
            return RestaurantCriticsScoreCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
}


struct SectionViewModel {
    let rowViewModels: [RowViewModel]
    let headerTitle: String?
    let headerViewModel : HeaderViewModel?
    let sectionHeight : Float
    let rowHeightForSection : Float
}
struct RestaurantTextVM:RowViewModel,ViewModelPressible {
    let titleText : String?
    let descriptionText : String?
    var cellType : RestaurantDetailCellType?
    let rowHeight = RestaurantDetailTextRowHeight
    var cellPressed: (() -> Void)? = nil
}
struct RestaurantPickaBooVM:RowViewModel {
    let resImageDetails : [ImageDetail]?
    var imageUrl:URL? {
        getImageUrl()
    }
    let rowHeight = RestaurantDetailPickaBooRowHeight
    func getImageUrl() ->URL?{
        //TODO: Get the correct image, right now getting proper image as 3rd object that's why hard coded
        if let imageDetails = self.resImageDetails,imageDetails.count > 0,let img = imageDetails[2].imageUrl{
            return URL.init(string:img)
        }
        return nil
    }
}
struct RestaurantInWordsVM:RowViewModel {
    let descriptionText : String?
    let rowHeight = UITableView.automaticDimension
}
struct RestaurantRatingVM:RowViewModel {
    let ratingArray : [String]?
    let rowHeight = RestaurantDetailRatingsRowHeight
}
struct HeaderViewModel {
    let imageUrlString : String?
    let rating: String?
    let restaurantName: String?
    let restaurantLocation: String?
    let restaurantCity: String?
    let openTime : String?
    let closeTime : String?
    let priceRangeText: String?
    let openDaysText: String?
    let resCategories : [RestaurantCategory]?
    var timingText: String?{
        if let openTiming = self.openTime, let closeTiming = closeTime{
            return openTiming + " - " + closeTiming
        }
        return nil
    }
    var imageUrl : URL?{
        if let imageURL = self.imageUrlString{
            return URL.init(string: imageURL)
            
        }
        return nil
    }
    var restaurantLocationText: String?{
        if let location = self.restaurantLocation, let city = restaurantCity{
            return location + " , " + city
        }
        return nil
    }
    var restaurantCuisineText : String{
        
        "Specialise Cuisine: " + self.cuisinesCombinedString()
    }
    var tagCollection: [String]?{
        self.buildTagCollection()
    }
    func cuisinesCombinedString() -> String {
        var cuisinesCombinedString = ""
        if let restaurantCategories = self.resCategories
        {
            for restaurant in restaurantCategories
            {
                if let isHashtag = restaurant.isHashtag
                {
                    if Int(isHashtag) == 0{
                        if let restaurantCategoryName = restaurant.restaurantCategoryName{
                            cuisinesCombinedString.append(restaurantCategoryName + ", ")
                        }
                    }
                }
            }
            cuisinesCombinedString = String(cuisinesCombinedString.dropLast(2))
        }
        return cuisinesCombinedString
    }
    func buildTagCollection() -> [String] {
        var tagCollection = [String]()
        if let restaurantCategories = self.resCategories
        {
            for restaurant in restaurantCategories
            {
                if let isHashtag = restaurant.isHashtag
                {
                    if Int(isHashtag) == 1{
                        if let restaurantCategoryName = restaurant.restaurantCategoryName{
                            tagCollection.append(restaurantCategoryName)
                        }
                    }
                }
            }
        }
        return tagCollection
    }
}

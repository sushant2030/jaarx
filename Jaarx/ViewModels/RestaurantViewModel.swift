//
//  RestaurantViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

class RestaurantViewModel {
    var restaurantCollectionVM = Observable<[RestaurantCellVM]>(value: [])
    let bucketType:BucketType?
    var edgeInset : UIEdgeInsets {
        get { getEdgeInsets() }
    }
    var minimumLineSpace : CGFloat {
        get { getMinimumLineSpace() }
    }
    init(restaurantDataCollection:[RestaurantCellVM], bucketType:BucketType) {
        self.bucketType = bucketType
        restaurantCollectionVM.value = restaurantDataCollection
    }
    
    func getGridSize(_ bounds:CGRect) -> CGSize {
        let width = (bounds.width - 60) / 3
        switch self.bucketType {
        case .banner,.carousel,.scanAndOrder:
            return CGSize.init(width: bounds.size.width - 30, height: bounds.size.height)
        case .hotcuisins:
            return CGSize.init(width: width, height: width)
        case .hashtags:
            return CGSize.init(width: 117, height: 42)
        default:
            return CGSize.init(width: width, height: (width * 2))
        }
    }
    func getEdgeInsets() -> UIEdgeInsets {
        switch self.bucketType {
        case .banner,.carousel:
            return UIEdgeInsets.init(top: 10, left: 15, bottom: 20, right: 15)
        case .scanAndOrder:
            return UIEdgeInsets.init(top: 20, left: 15, bottom: 10, right: 15)
        default:
            return UIEdgeInsets.init(top: 4, left: 15, bottom: 4, right: 15)
        }
    }
    
    func getMinimumLineSpace() -> CGFloat {
        switch self.bucketType {
        case .banner,.carousel,.scanAndOrder:
            return 0
        case .hashtags:
            return 5
        default:
            return 20
        }
    }
    
    func cellIdentifier() -> String {
        var cellIdentifier : String
        switch self.bucketType {
        case .critics,.mostscanned,.newlyOpened,.topPicks:
            cellIdentifier = LongCollectionCell.cellIdentifier()
        case .hotcuisins:
            cellIdentifier = SquareCollectionCell.cellIdentifier()
        case .hashtags:
            cellIdentifier = TagCollectionCell.cellIdentifier()
        default:
            cellIdentifier = LongCollectionCell.cellIdentifier()
        }
        return cellIdentifier
    }
}

class RestaurantCellVM:RowViewModel,ViewModelPressible {
    let restaurantId : String?
    let title : String?
    let location : String?
    let imageDetails : [ImageDetail]?
    let categoryName : String?
    let categoryColor : String?
    var imageUrl : URL? {
        get{self.getImageUrl()}
    }
    var cellButtonAction: ((CellAction) -> Void)? = nil
    var cellPressed: (() -> Void)? = nil
    init(restaurantId : String?, imageDetails:[ImageDetail]?,location : String?,title : String?,categoryName : String?,categoryColor : String?) {
        self.restaurantId = restaurantId
        self.imageDetails = imageDetails
        self.location = location
        self.title = title
        self.categoryName = categoryName
        self.categoryColor = categoryColor
        
    }
    
    func getImageUrl() ->URL?{
        if let imageDetails = self.imageDetails,imageDetails.count > 0,let img = imageDetails[0].imageUrl{
            return URL.init(string:img)
        }
        return nil
    }
}


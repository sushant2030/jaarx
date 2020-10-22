//
//  MenuViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//
import UIKit
import Foundation

class MenuViewModel {
    var cuisineCategories = Observable<[CategoryDetailVM]> (value: [])
    var currentMenuPage = Observable<IndexPath> (value: IndexPath.init(row: 0, section: 0))
    func getRestaurantMenu(resId : String)  {
        APIClient.getRestaurantDetailMenuFor(resId: "9") {[weak self] (response) in
            switch response {
            case .success(let menuResponse):
                if let menuData = menuResponse.menuData , menuData.count > 0 {
                    if let menuData = menuData[0].cuisineCategoryDetails {
                        for cuisineDetails in menuData {
                            let categoryDetail = CategoryDetailVM.init(with: cuisineDetails)
                            self?.cuisineCategories.value.append(categoryDetail)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func cellIdentifier(collectionViewType : MenuCollectionType) -> String {
        switch collectionViewType {
        case .header:
            return MenuHeaderCell.cellIdentifier()
        default:
            return MenuCategoryPageCell.cellIdentifier()
        }
    }
    
    func getCellSize(collectionView : UICollectionView, collectionViewType : MenuCollectionType) -> CGSize {
        switch collectionViewType {
        case .header:
            return CGSize.init(width: 100, height: collectionView.bounds.size.height)
        default:
            return collectionView.bounds.size
        }
        
    }
}

class CategoryDetailVM : RowViewModel {
    var cuisineCategoryId : String?
    var cuisineCategoryName : String?
    var cuisineSection : String?
    var menuId : String?
    var foodDetails : [FoodDetails]
    var isSelected : Bool?
    
    init(with categoryDetails : CuisineCategoryDetails ) {
        self.cuisineCategoryId = categoryDetails.cuisineCategoryId
        self.cuisineCategoryName = categoryDetails.cuisineCategoryName
        self.cuisineSection = categoryDetails.cuisineSection
        self.menuId = categoryDetails.menuId
        self.foodDetails = categoryDetails.foodDetails ?? []
    }
}


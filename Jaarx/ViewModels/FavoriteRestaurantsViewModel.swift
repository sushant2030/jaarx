//
//  FavoriteRestaurantsViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class FavoriteRestaurantsVM {
    var favoriteRestaurantVM = Observable<[RestaurantCellVM]> (value : [])
    var isLoading = Observable<Bool> (value: true)
    var cellButtonAction = Observable<RestaurantCellVM?> (value: nil)
    var rowHeight: CGFloat {
        get {
            return 250.0
        }
    }
    func buildFavoriteRestaurantViewModel(favoriteRestaurants:FavoriteRestaurantList) {
        if let favRestaurantList = favoriteRestaurants.favoriteData {
        for favoriteRestaurant in favRestaurantList{
            let restaurantVM = RestaurantCellVM.init(restaurantId: favoriteRestaurant.favRestaurant.resId, imageDetails: favoriteRestaurant.favRestaurant.resImageDetails, location: favoriteRestaurant.favRestaurant.resLocation, title: favoriteRestaurant.favRestaurant.resName, categoryName: nil, categoryColor: nil)
            self.favoriteRestaurantVM.value.append(restaurantVM)
        }
        }
    }
    
    func getFavoriteRestaurantsForUser(userId:String) {
        favoriteRestaurantVM.value = []
        APIClient.getFavoriteRestaurantsForUser(userId:userId) { (result) in
            switch result {
            case .success(let favoriteRestaurant):
                self.buildFavoriteRestaurantViewModel(favoriteRestaurants: favoriteRestaurant)
            case .failure(let error) :
                print(error)
            }
        }
    }
}



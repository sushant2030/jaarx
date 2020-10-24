//
//  FavoriteRestaurantsViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//
import Foundation
import UIKit

class FavoriteRestaurantsVM {
    var favoriteRestaurantVM = Observable<[RestaurantCellVM]> (value : [])
    func buildFavoriteRestaurantViewModel(favoriteRestaurants:FavoriteRestaurantList) {
        if let favRestaurantList = favoriteRestaurants.favoriteData {
        for favoriteRestaurant in favRestaurantList{
            let restaurantVM = RestaurantCellVM.init(restaurantId: favoriteRestaurant.favRestaurant.resId, imageDetails: favoriteRestaurant.favRestaurant.resImageDetails, location: favoriteRestaurant.favRestaurant.resLocation, title: favoriteRestaurant.favRestaurant.resName, categoryName: nil, categoryColor: nil)
            self.favoriteRestaurantVM.value.append(restaurantVM)
        }
        }
    }
    func getFavoriteRestaurantsForUser(userId:String) {
        APIClient.getFavoriteRestaurantsForUser(userId:userId) {[weak self] (result) in
            switch result {
            case .success(let favoriteRestaurant):
                self?.buildFavoriteRestaurantViewModel(favoriteRestaurants: favoriteRestaurant)
            case .failure(let error) :
                print(error)
            }
        }
    }
}



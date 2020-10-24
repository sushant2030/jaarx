//
//  SeeAllViewModel.swift
//  Jaarx
//
//  Created by Sumit Kumar on 24/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
class SeeAllRestaurantsVM {
     var seeAllRestaurantVM = Observable<[RestaurantCellVM]> (value : [])
    func getSeeMoreRestaurantsFor(type:String){
        APIClient.getSeeMoreRestaurantsForType(type: type) { (seeMoreResponse) in
            switch seeMoreResponse{
            case .success(let seeMoreRestaurants):
                print(seeMoreRestaurants)
                self.buildSeeAllRestaurantViewModel(seeAllRestaurants: seeMoreRestaurants)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func buildSeeAllRestaurantViewModel(seeAllRestaurants:[RestaurantDetail]) {
        for restaurant in seeAllRestaurants{
            let restaurantVM = RestaurantCellVM.init(restaurantId: restaurant.resId, imageDetails: restaurant.resImageDetails, location: restaurant.resLocation, title: restaurant.resName, categoryName: nil, categoryColor: nil)
            self.seeAllRestaurantVM.value.append(restaurantVM)
        }
    }
}

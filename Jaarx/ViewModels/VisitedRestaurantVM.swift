//
//  VisitedRestaurantVM.swift
//  Jaarx
//
//  Created by Sumit Kumar on 24/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

class VisitedRestaurantsVM {
     var visitedRestaurantVM = Observable<[RestaurantCellVM]> (value : [])
    
    func getSeeMoreRestaurantsFor(type:String){
        APIClient.getSeeMoreRestaurantsForType(type: type) { (seeMoreResponse) in
            switch seeMoreResponse{
            case .success(let seeMoreRestaurants):
                print(seeMoreRestaurants)
                self.buildVisitedRestaurantViewModel(visitedRestaurants: seeMoreRestaurants)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func buildVisitedRestaurantViewModel(visitedRestaurants:[RestaurantDetail]) {
        
        for restaurant in visitedRestaurants{
            let restaurantVM = RestaurantCellVM.init(restaurantId: restaurant.resId, imageDetails: restaurant.resImageDetails, location: restaurant.resLocation, title: restaurant.resName, categoryName: nil, categoryColor: nil)
            self.visitedRestaurantVM.value.append(restaurantVM)
        }
    }
}




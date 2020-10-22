//
//  EditCartViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 20/09/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

class EditCartViewModel {
    var carts = Observable<[FoodDetails]> (value: CartDataSource.sharedCart.carts.value)
    
    func getEditCartIdentifier() -> String {
        return EditCartCell.cellIdentifier()
    }
    
    func getCartCellIdentifier() -> String {
        return MenuTableCell.cellIdentifier()
    }
}

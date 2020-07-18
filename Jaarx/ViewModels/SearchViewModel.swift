//
//  SearchViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation

class SearchViewModel {
    var searchData = Observable<[SearchData]> (value : [])
    var isLoading = Observable<Bool> (value: true)
    var searchAction = Observable<SearchData?> (value: nil)
    func buildSearchViewModel(searchResponse:SearchReponse) {
        for searchResponseData in searchResponse.searchData ?? [] {
            let searchData = SearchData.init(id: searchResponseData.restaurantId, restaurantName: searchResponseData.restaurantName, location: searchResponseData.restaurantLocation ?? "", type: SearchResultType.init(rawValue: searchResponseData.type ?? "restaurant") ?? .restaurant, typeId: searchResponseData.typeId)
            self.searchData.value.append(searchData)
        }
    }
    
    func getSearchData(searchText:String) {
        APIClient.searchDataWithText(text: searchText) { (result) in
            switch result {
            case .success(let searchResponse):
                self.buildSearchViewModel(searchResponse: searchResponse)
            case .failure(let error) :
                print(error)
            }
        }
    }
}

class SearchData : RowViewModel {
    let id:String?
    let restaurantName:String?
    let location: String?
    let type: SearchResultType?
    let typeId : Int?
    var actionOnCell: ((CellAction) -> Void)? = nil
    init(id:String, restaurantName:String , location:String, type : SearchResultType, typeId : Int) {
        self.id = id
        self.restaurantName = restaurantName
        self.location = location
        self.type = type
        self.typeId = typeId
    }
}

//
//  SearchViewModel.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel {
    var searchData = Observable<[SearchData]> (value : [])
    var isLoading = Observable<Bool> (value: true)
    var cellButtonAction = Observable<SearchData?> (value: nil)
    var rowHeight: CGFloat {
        get {
            return 250.0
        }
    }
    func buildSearchViewModel(searchResponse:SearchReponse) {
        for searchResponseData in searchResponse.searchData ?? [] {
            let searchData = SearchData.init(id: searchResponseData.restaurantId, restaurantName: searchResponseData.restaurantName, location: searchResponseData.restaurantLocation ?? "", type: SearchResultType.init(rawValue: searchResponseData.type ?? "restaurant") ?? .restaurant, typeId: searchResponseData.typeId, imagePath: searchResponseData.thumbnailImage ?? "")
            self.searchData.value.append(searchData)
        }
    }
    
    func getSearchData(searchText:String) {
        searchData.value = []
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
    var cellButtonAction: ((CellAction) -> Void)? = nil
    let imagePath : String?
    var imageUrl : URL? {
        get{self.getImageUrl()}
    }
    init(id:String, restaurantName:String , location:String, type : SearchResultType, typeId : Int,imagePath : String) {
        self.id = id
        self.restaurantName = restaurantName
        self.location = location
        self.type = type
        self.typeId = typeId
        self.imagePath = imagePath
    }
    
    func getImageUrl() ->URL?{
        if let imagePath = self.imagePath,imagePath.count > 0 {
            return URL.init(string:"https://jaarx.com/images/restaurants/1/rest-1-1.jpg")
        }
        return nil
    }
}

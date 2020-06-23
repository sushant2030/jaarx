//
//  APIClient.swift
//  Jaarx
//
//  Created by Sumit Kumar on 14/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import Alamofire
class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
        return AF.request(route).validate(statusCode: 200..<300)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                switch response.result {
                case .success(_):
                    print("Response is successful")
                case .failure(let error):
                    print(error)
                }
                completion(response.result)
        }
    }
    static func getHomeData(completion:@escaping (AFResult<HomeResponse>)->Void){
        do {
            let homeRouter = try HomeRouter.home.asURLRequest()
            performRequest(route: homeRouter, completion:completion )
            
        }
        catch (let error){
            print(error)
        }
    }
    
    static func addOrderWith(params:[String:Any], completion:@escaping (AFResult<AddOrderResponse>)->Void){
           do {
            let userRouter = try UserRouter.addOrder(params: params).asURLRequest()
               performRequest(route: userRouter, completion:completion )
           }
           catch (let error){
               print(error)
           }
       }
}





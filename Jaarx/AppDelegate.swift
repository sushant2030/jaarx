//
//  AppDelegate.swift
//  Jaarx
//
//  Created by Sushant Alone on 03/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//    
        
        APIClient.signInWithPhoneNumber(user: User()) { (response) in
            print(response)
        }
//        APIClient.requestOTPForPhoneNumber(user: User()) { (response) in
//            if let code = response.response?.statusCode {
//                
//            } else {
//
//            }
//        }
//        APIClient.getHomeData { (homeResponse) in
//       //     print(homeResponse)
//        }
////        let parameters: [String: Any] = [
////            "user_id" : "dda17e3d-fc66-49ae-a24d-1c832d9c71b4",
////            "table_id" : 1,
////            "food_items": [
////                [
////                    "food_id" : 1001,
////                    "quantity": 7
////                ],
////                [
////                    "food_id" : 1003,
////                    "quantity": 4
////                ]
////            ]
////        ]
//       let parameters: [String: Any] = [
//            "user_id" : "ea5d6d15-b83e-4110-95a3-e049895ea7b9",
//            "deviceToken"  : "dMLIHIE8TUuQhpDPd2UvA8:APA91bFcjfjyZW1OgFzyEyVw0QyxnMIkVKcMed5zBhvALm-o35t3pmCWwK_4elTseRdJ1lEhOeFphL2uFoymrT3EoCDDByd2veswkjhA18CWlO8FANt1OwHlk5eIDdDmNOnCbNHZRf-G",
//            "deviceOS" : "iOS"
//        ]
//        APIClient.registerDeviceWith(params: parameters) { (response) in
//     //       print(response)
//        }
//        let bookTableParameters: [String: Any] = [
//            "date" : "12-12-1992",
//            "time" : "13:00",
//            "res_id" : 11,
//            "order_id" : 72,
//            "noOfPersons" : 5,
//            "user_id" : "81952a9e-7016-4e58-9e43-d4bb0900ee91"
//        ]
//        APIClient.bookTableWith(params: bookTableParameters){ (response) in
//  //      print(response)
//            
//        }
//        let updateBookingParameters: [String: Any] = [
//                   "status" : "accepted",
//                   "dineinTableId" : 1,
//                   "tableBookingId" : 10018
//               ]
//               APIClient.updateBookingWith(params: updateBookingParameters){ (response) in
//               print(response)
//               }
//        if let parameters = Helper.loadJson(filename: "AddOrder"){
//        APIClient.addOrderWith(params: parameters) { (addOrderResponse) in
//       //     print(addOrderResponse)
//        }
//        }
//        let favoriteBookingParameters: [String: Any] = [
//            "user_id" : "cf576a22-8254-47e9-a906-d2a0e82c5b14",
//            "res_id"  : 12,
//            "status"  : true
//        ]
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Jaarx")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


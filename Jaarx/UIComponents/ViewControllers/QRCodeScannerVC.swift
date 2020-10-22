//
//  QRCodeScannerVC.swift
//  Jaarx
//
//  Created by Sumit Kumar on 13/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class QRCodeScannerVC: UIViewController {
    
    @IBOutlet weak var qrScannerView: QRScannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrScannerView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension QRCodeScannerVC : QRScannerViewDelegate {
    func qrScanningDidFail() {
        
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        if let restaurantTableString = str {
            let paramArray = restaurantTableString.components(separatedBy: "_")
            if paramArray.count > 1 {
                let resId = paramArray[0]
                let tableId = paramArray[1]
                CartDataSource.sharedCart.user.tableId = Int(tableId)!
                CartDataSource.sharedCart.userFlow = .scan
                if let menuVC = UIStoryboard.menuVC() {
                    menuVC.setRestaurantId(resId: resId)
                    self.navigationController?.pushViewController(menuVC, animated: true)
                }
            }
        }
    }
    
    func qrScanningDidStop() {
        
    }
    
    
}

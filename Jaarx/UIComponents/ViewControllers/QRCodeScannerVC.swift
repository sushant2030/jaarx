//
//  QRCodeScannerVC.swift
//  Jaarx
//
//  Created by Sumit Kumar on 13/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class QRCodeScannerVC: UIViewController {

    @IBOutlet weak var scanView: QRScannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scanView.delegate = self
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
        
    }
    
    func qrScanningDidStop() {
        
    }
    
    
}

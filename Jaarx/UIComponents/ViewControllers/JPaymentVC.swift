//
//  JPaymentVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 21/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit
import WebKit

class JPaymentVC: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

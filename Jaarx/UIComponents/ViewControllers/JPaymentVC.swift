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
        if let paymentRequest = APIClient.getPaymentUrl() {
            wkWebView.navigationDelegate = self
            wkWebView.load(paymentRequest)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension JPaymentVC : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let text = webView.url?.absoluteString{
            if text.contains("/payment/payUFail") {
                UserDataSource.sharedInstance.transactionStatus = .fail
                if UserDataSource.sharedInstance.userFlow == .preOrder {
                Helper.extractOrderIdFromUrl(url : text)
                }
                self.dismiss(animated: true, completion: nil)
            } else if text.contains("/payment/payUSuccess") {
                if UserDataSource.sharedInstance.userFlow == .preOrder {
                    UserDataSource.sharedInstance.transactionStatus = .preorderSuccess
                    Helper.extractOrderIdFromUrl(url : text)
                } else {
                    UserDataSource.sharedInstance.transactionStatus = .success
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

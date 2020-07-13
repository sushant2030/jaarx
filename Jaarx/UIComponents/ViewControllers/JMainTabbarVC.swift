//
//  JMainTabbarVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 10/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JMainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()

        // Do any additional setup after loading the view.
    }
    
    
    func setupViewControllers()  {
        let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeVC")
        let navigationVC = JNavigationVC.init(rootViewController: homeVC)
        
        let qrCodeScannerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "QRCodeScannerVC")
        let navigationVC2 = JNavigationVC.init(rootViewController: qrCodeScannerVC)
        
        self.viewControllers = [navigationVC,navigationVC2]
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

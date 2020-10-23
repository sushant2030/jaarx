//
//  JCashVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JCashVC: UIViewController {

    @IBOutlet weak var lblValidationCode: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblGSTValue: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var billInfoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        installViews()
        // Do any additional setup after loading the view.
    }
    
    func installViews()  {
        if let cashDetails = UserDataSource.sharedInstance.cashDetails {
            lblOrderNo.text = "\(UserDataSource.sharedInstance.user.orderId ?? 0)"
            lblOffer.text = "₹0.0"
            lblSubTotalValue.text = "₹\(cashDetails.sub ?? "")"
            lblTotal.text = "₹\(cashDetails.total ?? "")"
            lblGSTValue.text = "₹\(cashDetails.gst ?? "")"
        }
        
        billInfoView.makeViewCornerRadiusWithRadi(radius: 15.0)
        billInfoView.dropShadow(scale: true)
        let rectShape = CAShapeLayer()
        rectShape.bounds = abstractView.frame
        rectShape.position = abstractView.center
        rectShape.path = UIBezierPath(roundedRect: abstractView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 100, height: 120)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        abstractView.layer.mask = rectShape
        abstractView.dropShadow(scale: true)
    }
    

    @IBAction func actionBack(_ sender: UIButton) {
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

//
//  PaymentFailureVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 25/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class PaymentFailureVC: UIViewController {

    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var billInfoView: UIView!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblOfferDiscountValue: UILabel!
    @IBOutlet weak var lblTotalCostValue: UILabel!
    @IBOutlet weak var lblGSTValue: UILabel!
    var checkoutVM : CheckoutVM?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayPaymentInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        abstractView.makeSelectedCornersRounded()
        abstractView.dropShadow(scale: true)
        billInfoView.makeViewCornerRadiusWithRadi(radius: 10.0)
        billInfoView.dropShadow(scale: true)
    }
    
    func setBillInfo(checkoutVM : CheckoutVM) {
        self.checkoutVM = checkoutVM
    }
    
    func displayPaymentInfo()  {
        if let orderId = UserDataSource.sharedInstance.user.orderId {
            lblOrderNo.text = "Order No \(orderId)"
        }
        if let checkoutVM = checkoutVM{
        lblSubTotalValue.text = "₹ \(checkoutVM.subTotal.value)"
        lblOfferDiscountValue.text = "₹\(checkoutVM.offerDiscount.value)"
        lblGSTValue.text = "₹\(checkoutVM.gst.value)"
        lblTotalCostValue.text = "₹\(checkoutVM.total.value)"
        }
    }

    @IBAction func dismiss(_ sender: Any) {
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

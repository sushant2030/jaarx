//
//  PaymentConfirmationVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 25/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class PaymentConfirmationVC: UIViewController {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGst: UILabel!
    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var billInfoView: UIView!
    var checkoutVM : CheckoutVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
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
    
    func setCheckOutInfo(checkoutVM : CheckoutVM)  {
        self.checkoutVM = checkoutVM
    }
    
    func bindData() {
        orderTableView.register(UINib.init(nibName:  OrderListShadowCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier:  OrderListShadowCell.cellIdentifier())
        orderTableView.delegate = self
        orderTableView.dataSource = self
        self.orderTableView.backgroundColor = .clear
        self.orderTableView.separatorColor = .clear
    }
    
    func displayPaymentInfo()  {
        if let orderId = UserDataSource.sharedInstance.user.orderId {
            lblOrderNo.text = "Order No \(orderId)"
        }
        if let checkoutVM = checkoutVM{
        lblSubTotal.text = "₹ \(checkoutVM.subTotal.value)"
        lblDiscount.text = "₹\(checkoutVM.offerDiscount.value)"
        lblGst.text = "₹\(checkoutVM.gst.value)"
        lblTotal.text = "₹\(checkoutVM.total.value)"
        }
        self.view.backgroundColor = UIColor().getHexColor(hex: "#05CD96")
   
        
    }
    @IBAction func dismiss(_ sender: Any) {
        UserDataSource.sharedInstance.carts.value = []
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension PaymentConfirmationVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let checkoutVM = checkoutVM{
        return checkoutVM.foodData.value.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListShadowCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: checkoutVM!.foodData.value[indexPath.row])
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
}

//
//  JCheckoutVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 21/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JCheckoutVC: UIViewController {

    @IBOutlet weak var billInfoView: UIView!
    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblGST: UILabel!
    @IBOutlet weak var lblOfferDiscount: UILabel!
    @IBOutlet weak var btnPromoCode: UIButton!
    @IBOutlet weak var lblTotalCost: UILabel!
    @IBOutlet weak var btnSkipView: UIStackView!
    @IBOutlet weak var btnAction: UIButton!
    let checkoutVM = CheckoutVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutVM.setUserFlow(withMode: UserDataSource.sharedInstance.userFlow)
        bindData()
        installView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkoutVM.getDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        abstractView.makeSelectedCornersRounded()
        abstractView.dropShadow(scale: true)
    }
    
    func installView()  {
        orderTableView.separatorColor = .clear
        orderTableView.delegate = self
        orderTableView.dataSource =  self
        orderTableView.register(UINib.init(nibName: OrderListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: OrderListCell.cellIdentifier())
        billInfoView.makeViewCornerRadiusWithRadi(radius: 15.0)
        billInfoView.dropShadow(scale: true)
        btnAction.makeCornerRadiusWithRadi(radius: 10.0)
        btnAction.dropShadow(scale: true)
        

        if checkoutVM.userFlow == .preOrder {
            checkoutVM.paymentMode.value = .online
            btnSkipView.isHidden = true
            self.btnAction.setTitle("Pay Online", for: .normal)
        } else {
            btnAction.backgroundColor = UIColor().getHexColor(hex: "#2FFF2F")
            self.btnAction.setTitle("Pay Cash", for: .normal)
        }
    }
    
    func bindData() {
        checkoutVM.gst.addObserver(fireNow: false) { (value) in
            self.lblGST.text = "₹\(value)"
        }
        checkoutVM.offerDiscount.addObserver(fireNow: false) { (value) in
            self.lblOfferDiscount.text = "₹\(value)"
        }
        checkoutVM.subTotal.addObserver(fireNow: false) { (value) in
            self.lblSubTotalValue.text = "₹\(value)"
        }
        checkoutVM.total.addObserver(fireNow: false) { (value) in
            self.lblTotalCost.text = "₹\(value)"
        }
        checkoutVM.foodData.addObserver(fireNow: false) { (value) in
            self.orderTableView.reloadData()
        }
        checkoutVM.paymentMode.addObserver(fireNow: false) { (paymentMode) in
            switch paymentMode {
            case .cash:
                self.btnAction.setTitle("Pay Cash", for: .normal)
                self.btnAction.backgroundColor = UIColor().getHexColor(hex: "#2FFF2F")
            case .online:
                self.btnAction.setTitle("Pay Online", for: .normal )
                self.btnAction.backgroundColor = UIColor().getHexColor(hex: "#009EFD")
            }
        }
        checkoutVM.orderNo.addObserver(fireNow: false) { (value) in
            self.lblOrderNo.text = "orderNo \(value)"
        }
        checkoutVM.paymentStatus.addObserver(fireNow: false) { (value) in
            switch UserDataSource.sharedInstance.transactionStatus {
            case .noTransaction:
                print("")
            case .fail:
                self.presentPaymentFailurePage()
            case .success:
                self.presentPaymentConfirmationPage()
            case .preorderSuccess:
                self.presentPreOrder()
            default:
                print("")
            }
        }
    }
    
    @IBAction func actionPayment(_ sender: UIButton) {
        switch checkoutVM.paymentMode.value {
        case .cash:
            if let cashVC = UIStoryboard.cashVC() {
                cashVC.modalPresentationStyle = .fullScreen
                self.present(cashVC, animated: true, completion: nil)
            }
        case .online:
            if let paymentVC = UIStoryboard.paymentVC() {
                paymentVC.modalPresentationStyle = .fullScreen
                self.present(paymentVC, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionSkipWaitTime(_ sender: UIButton) {
        btnSkip.isSelected = !btnSkip.isSelected
        if btnSkip.isSelected {
            checkoutVM.paymentMode.value = .online
        } else {
            checkoutVM.paymentMode.value = .cash
        }
        
    }
    @IBAction func actionPromocode(_ sender: UIButton) {
        
    }
    
    func presentPaymentConfirmationPage()  {
        if let paymentPage = UIStoryboard.paymentConfirmationVC() {
            paymentPage.modalPresentationStyle = .fullScreen
            paymentPage.setCheckOutInfo(checkoutVM: checkoutVM)
            self.present(paymentPage, animated: true, completion: nil)
        }
    }
    
    func presentPaymentFailurePage() {
        if let paymentPage = UIStoryboard.paymentFailureVC() {
            paymentPage.setBillInfo(checkoutVM: checkoutVM)
            paymentPage.modalPresentationStyle = .fullScreen
            self.present(paymentPage, animated: true, completion: nil)
        }
    }
    
    func presentPreOrder()  {
        if let preOrderConfirmation = UIStoryboard.preOrderConfirmation() {
            preOrderConfirmation.modalPresentationStyle = .fullScreen
            self.present(preOrderConfirmation, animated: true, completion: nil)
        }
    }
}

extension JCheckoutVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutVM.foodData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: checkoutVM.getCellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: checkoutVM.foodData.value[indexPath.row])
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return checkoutVM.getHeightForRow()
    }
}

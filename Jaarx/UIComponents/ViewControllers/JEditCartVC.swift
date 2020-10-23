//
//  JEditCartVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 20/09/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JEditCartVC: UIViewController {
    @IBOutlet weak var testView: UIView!
    let editCartVM = EditCartViewModel()
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var btnPlaceHolder: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView()
        makeCornerRadius()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editCartVM.carts.value = UserDataSource.sharedInstance.carts.value
    }
    
    func registerView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib.init(nibName: editCartVM.getEditCartIdentifier(), bundle: nil), forCellReuseIdentifier: editCartVM.getEditCartIdentifier())
    }
    
    private func makeCornerRadius()   {
        let rectShape = CAShapeLayer()
        rectShape.bounds = testView.frame
        rectShape.position = testView.center
        rectShape.path = UIBezierPath(roundedRect: testView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 50, height: 80)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        testView.layer.mask = rectShape
        cartTableView.backgroundColor = .clear
        btnPlaceHolder.makeCornerRadiusWithRadi(radius: 5.0)
    }
    
    func bindData()  {
        editCartVM.carts.addObserver(fireNow: true) { [weak self] (carts) in
            DispatchQueue.main.async {
                self?.cartTableView.reloadData()
            }
        }
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func actionPlaceOrder(_ sender: UIButton) {
        UserDataSource.sharedInstance.userFlow = .scan
        switch UserDataSource.sharedInstance.userFlow {
        case .preOrder:
            UserDataSource.sharedInstance.addCart { (isSuccess) in
                if isSuccess {
                    if let checkoutVC = UIStoryboard.checkOutVC() {
                        checkoutVC.modalPresentationStyle = .fullScreen
                        self.present(checkoutVC, animated: true, completion: nil)
                    }
                } else {
                    //SHOW ERROR
                }
            }
        default:
            UserDataSource.sharedInstance.addOrder { (isSuccess) in
                if isSuccess {
                    if let orderHub = UIStoryboard.orderHub() {
                        orderHub.modalPresentationStyle = .fullScreen
                        self.present(orderHub, animated: true, completion: nil)
                    }
                } else {
                    //SHOW ERROR
                }
            }
        }
        
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


extension JEditCartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = UserDataSource.sharedInstance.carts.value.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editCartVM.getEditCartIdentifier(), for: indexPath)
        let cart = editCartVM.carts.value[indexPath.item]
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: cart)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
}

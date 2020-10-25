//
//  JOrderHubVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 23/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JOrderHubVC: UIViewController {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var restaurantHolderView: UIView!
    @IBOutlet weak var finalOrderView: UIView!
    @IBOutlet weak var lblOrderTableView: UITableView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblRestaurant: UILabel!
    @IBOutlet weak var restaurantImgView: UIImageView!
    let orderHubViewModel = OrderHubViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        regsiterView()
        orderHubViewModel.getOrderDetails()
        // Do any additional setup after loading the view.
    }
    
    func regsiterView() {
        lblOrderTableView.delegate = self
        lblOrderTableView.dataSource = self
        lblOrderTableView.register(UINib.init(nibName: OrderHubCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: OrderHubCell.cellIdentifier())
        lblOrderTableView.separatorColor = .clear
        restaurantHolderView.dropShadow(scale: true)
        finalOrderView.dropShadow(scale: true)
    }
    
    func bindData() {
        
        orderHubViewModel.totalCost.addObserver(fireNow: true) { (value) in
            self.lblTotal.text = value
        }
        orderHubViewModel.restaurantName.addObserver(fireNow: true) { (value) in
            self.lblRestaurant.text = value
        }
        orderHubViewModel.restaurantLocation.addObserver(fireNow: true) { (value) in
            self.lblLocation.text = value
        }
        orderHubViewModel.servedFoodData.addObserver(fireNow: true) { (value) in
            DispatchQueue.main.async {
                self.lblOrderTableView.reloadData()
            }
        }
        orderHubViewModel.pendingFoodData.addObserver(fireNow: true) { (value) in
            DispatchQueue.main.async {
                self.lblOrderTableView.reloadData()
            }
        }
    }
    @IBAction func actionClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOrderFood(_ sender: Any) {
    }
    
    @IBAction func actionBillGeneration(_ sender: Any) {
        if let checkoutVC = UIStoryboard.checkOutVC() {
                               checkoutVC.modalPresentationStyle = .fullScreen
                               self.present(checkoutVC, animated: true, completion: nil)
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


extension JOrderHubVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderHubViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return orderHubViewModel.pendingFoodData.value.count
        default:
            return orderHubViewModel.servedFoodData.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 10, width: tableView.bounds.width, height: 100
        ))
        view.backgroundColor = .white
        let label = UILabel.init(frame: CGRect.init(x: 4, y: 0, width: view.bounds.width, height: 30))
        label.text = section == 0 ? "Pending Orders" : "Served Orders"
        label.font = UIFont.init(name: "Helvetica Neue", size: 25)
        label.textColor = UIColor().getHexColor(hex: "#009EFD")
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderHubCell.cellIdentifier(), for: indexPath)
        switch indexPath.section {
        case 0:
            if let cell = cell as? CellConfigurable {
                cell.setup(viewModel: orderHubViewModel.pendingFoodData.value[indexPath.row])
            }
        default:
            if let cell = cell as? CellConfigurable {
                cell.setup(viewModel: orderHubViewModel.servedFoodData.value[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

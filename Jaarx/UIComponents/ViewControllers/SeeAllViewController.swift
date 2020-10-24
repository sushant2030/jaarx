//
//  SeeAllViewController.swift
//  Jaarx
//
//  Created by Sumit Kumar on 24/10/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class SeeAllViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var seeAllTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let seeAllRestaurantsVM = SeeAllRestaurantsVM()
    
    var restaurantType : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar(WithTitle: "Account")
        if let restaurantType = restaurantType{
            self.seeAllRestaurantsVM.getSeeMoreRestaurantsFor(type: restaurantType)
            setNavigationBar(WithTitle:restaurantType)
        }
        
        self.bindData()
    }
    func registerDelegateAndDataSource() {
        self.seeAllTableView.delegate = self
        self.seeAllTableView.dataSource = self
        seeAllTableView.register(UINib.init(nibName: RestaurantListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantListCell.cellIdentifier())
    }
    func bindData() {
        self.activityIndicator.startAnimating()
        seeAllRestaurantsVM.seeAllRestaurantVM.addObserver(fireNow: false) { [weak self] (seeAllResVMs) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                for seeAllRes in seeAllResVMs{
                    seeAllRes.cellButtonAction = self?.handleCellButtonAction(viewModel: seeAllRes)
                    seeAllRes.cellPressed = {
                        if let restaurantId = seeAllRes.restaurantId{
                            self?.navigateToRestaurantDetailVC(restaurantId:restaurantId)
                        }
                    }
                }
                self?.registerDelegateAndDataSource()
                self?.seeAllTableView.reloadData()
            }
        }
    }
    
    // MARK: - User interaction
    func handleCellButtonAction(viewModel : RestaurantCellVM) -> ((CellAction) -> Void) {
        return { [weak self, weak viewModel] action in
            switch action {
            case .preOrder:
                if let restaurantId = viewModel?.restaurantId{
                    self?.navigateToPreOrder(restaurantId:restaurantId )
                }
            case . scan:
                if let restaurantId = viewModel?.restaurantId{
                    self?.navigateToQRCodeScannerVC(restaurantId:restaurantId )
                }
            }
            
        }
    }
    func navigateToQRCodeScannerVC(restaurantId:String) {
        if let qrCodeScannerVC = UIStoryboard.qrCodeScannerVC(){
            self.navigationController?.pushViewController(qrCodeScannerVC, animated: true)
        }
    }
    
    func navigateToPreOrder(restaurantId:String) {
        if let preOrderVC = UIStoryboard.preOrderVC(){
            self.navigationController?.pushViewController(preOrderVC, animated: true)
        }
    }
    func navigateToRestaurantDetailVC(restaurantId:String) {
        if let restaurantDetailVC = UIStoryboard.restaurantDetailVCWithRestaurant(id: restaurantId){
            self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
        }
    }
}

extension SeeAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seeAllRestaurantsVM.seeAllRestaurantVM.value.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BucketCellHeight.large.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let seeAllResVM = seeAllRestaurantsVM.seeAllRestaurantVM.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable{
            cell.setup(viewModel: seeAllResVM)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seeAllRes = seeAllRestaurantsVM.seeAllRestaurantVM.value[indexPath.row]
        seeAllRes.cellPressed?()
        
    }
    
}

//
//  AccountVC.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let accountVM = AccountViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar(WithTitle: "Account")
        self.accountVM.favoriteRestaurantVM.getFavoriteRestaurantsForUser(userId: "e74996b1-22c4-43a3-886c-2ddc9763f798")
        self.accountVM.visitedRestaurantVM.getSeeMoreRestaurantsFor(type: "scanned")
        self.bindData()
    }
    func registerDelegateAndDataSource() {
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        accountTableView.register(UINib.init(nibName: AccountTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: AccountTableCell.cellIdentifier())
        if let view = AccountHeaderView.instanceFromNib() as? AccountHeaderView{
            accountTableView.tableHeaderView = view
            accountTableView.tableHeaderView?.frame.size.height = 300.0
            view.buttonAction = {sender in
                self.headerViewButtonAction(sender: sender)
            }
        }
    }
    func bindData() {
        self.activityIndicator.startAnimating()
        self.accountVM.visitedRestaurantVM.visitedRestaurantVM.addObserver(fireNow: false) { [weak self] (visitedResVMs) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                for visitedRes in visitedResVMs{
                    visitedRes.cellButtonAction = self?.handleCellButtonAction(viewModel: visitedRes)
                    visitedRes.cellPressed = {
                        if let restaurantId = visitedRes.restaurantId{
                            self?.navigateToRestaurantDetailVC(restaurantId:restaurantId)
                        }
                    }
                }
                self?.registerDelegateAndDataSource()
                self?.accountTableView.reloadData()
            }
        }
        self.accountVM.favoriteRestaurantVM.favoriteRestaurantVM.addObserver(fireNow: false) { [weak self] (favResVMs) in
                       DispatchQueue.main.async {
                           for favRes in favResVMs{
                               favRes.cellButtonAction = self?.handleCellButtonAction(viewModel: favRes)
                               favRes.cellPressed = {
                                   if let restaurantId = favRes.restaurantId{
                                       self?.navigateToRestaurantDetailVC(restaurantId:restaurantId)
                                   }
                               }
                           }
                       }
                   }
    }
    
    func headerViewButtonAction(sender:UIButton)   {
        if let cell = accountTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? AccountTableCell{
            cell.accountViewCollectionCell .scrollToItem(at: IndexPath.init(item: sender.tag-1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func accountCollectionCellScrolledPage(page:Int)   {
        if let view = accountTableView.tableHeaderView as? AccountHeaderView{
            view.hightLightSelectedViewWithTag(tag: page)
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

extension AccountVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.containerView.frame.height - (self.accountTableView.tableHeaderView?.frame.height)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AccountTableCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? AccountTableCell
        {
            cell.accountCollectionCurrentPage = { page in
                self.accountCollectionCellScrolledPage(page: page)
            }
            cell.accountVM = self.accountVM
        }
        return cell
    }
}
extension AccountVC: UITableViewDelegate {
    
}

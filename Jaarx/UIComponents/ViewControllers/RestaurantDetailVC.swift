//
//  RestaurantDetailVC.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit
class RestaurantDetailVC : UIViewController{
    @IBOutlet weak var restaurantDetailTableView: UITableView!
    var restaurantId : String?
    var restaurantDetailVM : RestaurantDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDelegateAndDataSource()
        self.restaurantDetailVM = RestaurantDetailViewModel.init(restaurantId: self.restaurantId!)
        self.bindData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        CartDataSource.sharedCart = nil
    }
    func registerDelegateAndDataSource() {
        self.restaurantDetailTableView.delegate = self
        self.restaurantDetailTableView.dataSource = self
        self.restaurantDetailTableView.register(
            RestaurantDetailViewHeader.nib,
            forHeaderFooterViewReuseIdentifier:
            RestaurantDetailViewHeader.reuseIdentifier
        )
        restaurantDetailTableView.register(UINib.init(nibName: RestaurantDetailTextCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantDetailTextCell.cellIdentifier())
        restaurantDetailTableView.register(UINib.init(nibName: RestaurantPickaBooCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantPickaBooCell.cellIdentifier())
        restaurantDetailTableView.register(UINib.init(nibName: RestaurantInWordsCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantInWordsCell.cellIdentifier())
        restaurantDetailTableView.register(UINib.init(nibName: RestaurantCriticsScoreCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantCriticsScoreCell.cellIdentifier())
        
        
    }
    func bindData(){
        restaurantDetailVM!.restaurantHeaderVM.addObserver(fireNow: false) { [weak self] (restaurantHeaderVM) in
            DispatchQueue.main.async {
                self?.restaurantDetailTableView.reloadData()
                self?.restaurantDetailTableView.isHidden = false
                self?.navigationItem.title = restaurantHeaderVM?.restaurantName ?? ""
                let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.init(name: "Helvetica Neue", size: 25)]
                self?.navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
            }
        }
        restaurantDetailVM!.isLoading.addObserver {[weak self] isLoading in
            DispatchQueue.main.async {
                if (isLoading){
                    self?.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.3))
                    self?.restaurantDetailTableView.isHidden = true
                }
                else{
                    self?.view.activityStopAnimating()
                    self?.restaurantDetailTableView.isHidden = false
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
//        if let preOrderVC = UIStoryboard.preOrderVC(){
//            self.navigationController?.pushViewController(preOrderVC, animated: true)
//        }
        if let menuVC = UIStoryboard.menuVC() {
            menuVC.setRestaurantId(resId: restaurantId, name: restaurantDetailVM?.restaurantHeaderVM.value?.restaurantName ?? "")
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
}

extension RestaurantDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantDetailVM!.sectionVMs.value[section].rowViewModels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionViewModel = self.restaurantDetailVM!.sectionVMs.value[indexPath.section]
        return CGFloat(sectionViewModel.rowHeightForSection)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.restaurantDetailVM!.sectionVMs.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionViewModel = self.restaurantDetailVM!.sectionVMs.value[indexPath.section]
        let rowModel = sectionViewModel.rowViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:self.restaurantDetailVM!.cellIdentifier(for: rowModel), for: indexPath)
        if let cell = cell as? CellConfigurable
        {
            cell.setup(viewModel: rowModel)
        }
        return cell
    }
    
}

extension RestaurantDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let sectionViewModel = self.restaurantDetailVM!.sectionVMs.value[section]
        if let restaurantHeaderVM = sectionViewModel.headerViewModel{
            guard let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: RestaurantDetailViewHeader.reuseIdentifier)
                as? RestaurantDetailViewHeader
                else {
                    return nil
            }
            view.configureHeaderViewWith(headerVM: restaurantHeaderVM)
            return view
        }
        else{
            let view = RestaurantDetailSectionHeader.instanceFromNib()
            if let sectionTitle = sectionViewModel.headerTitle{
                view.sectionTitleLabel.text = sectionTitle
            }
            return view
        }
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return  CGFloat(self.restaurantDetailVM!.sectionVMs.value[section].sectionHeight)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionViewModel = self.restaurantDetailVM!.sectionVMs.value[indexPath.section]
        let rowModel = sectionViewModel.rowViewModels[indexPath.row]
        if let rowModel = rowModel as? RestaurantTextVM
        {
            if let restID = self.restaurantId{
                switch rowModel.cellType {
                case .ScanNOrder :
                    self.navigateToQRCodeScannerVC(restaurantId: restID)
                case .ReserveNOrder :
                    self.navigateToPreOrder(restaurantId: restID)
                case .none:
                    break
                }
            }

        }
    }
}


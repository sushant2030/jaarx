//
//  HomeVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 05/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var homeTableView: UITableView!
    var homeViewModel : HomeViewModel = HomeViewModel()
    var scanButtonAction : (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegateAndDataSource()
        homeViewModel.getHomeData()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func registerDelegateAndDataSource() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib.init(nibName: BucketCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: BucketCell.cellIdentifier())
        homeTableView.register(UINib.init(nibName: CarouselTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: CarouselTableCell.cellIdentifier())
    }
    
    func bindData(){
        homeViewModel.homeTableViewModel.addObserver(fireNow: false) { [weak self] (homeVMs) in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
                self?.homeTableView.isHidden = false
                for homeVM in homeVMs{
                    let restaurantViewModel = homeVM.restaurantViewModel
                    for restaurantCellVM in restaurantViewModel?.restaurantCollectionVM.value ?? []{
                        restaurantCellVM.scanBtnPressed = self?.handleScanAction(viewModel: restaurantCellVM)
                    }
                }
            }
        }
        homeViewModel.isLoading.addObserver {[weak self] isLoading in
            DispatchQueue.main.async {
                if (isLoading){
                    self?.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
                    self?.homeTableView.isHidden = true
                }
                else{
                    self?.view.activityStopAnimating()
                }
            }
        }
    }
    // MARK: - User interaction
    func handleScanAction(viewModel : RestaurantCellVM) -> (() -> Void) {
        return { [weak self, weak viewModel] in
            if let restaurantId = viewModel?.restaurantId{
                self?.navigateToQRCodeScannerVC(restaurantId:restaurantId )
            }
        }
    }
    func navigateToQRCodeScannerVC(restaurantId:String) {
        if let qrCodeScannerVC = UIStoryboard.qrCodeScannerVC(){
            self.navigationController?.pushViewController(qrCodeScannerVC, animated: true)
        }
    }
}

//MARK: - UITableView DataSource
extension HomeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let homeBucketData = homeViewModel.homeTableViewModel.value[indexPath.row]
        return homeBucketData.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.homeViewModel.homeTableViewModel.value.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeRowVM = homeViewModel.homeTableViewModel.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: homeRowVM.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable{
            cell.setup(viewModel: homeRowVM)
        }
        return cell
    }
}

//MARK: - UITableView Delegate
extension HomeVC : UITableViewDelegate {
    
}


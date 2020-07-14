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
    }
    
    func bindData(){
        homeViewModel.homeTableViewModel.addObserver(fireNow: false) { [weak self] (homeResponse) in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
                self?.homeTableView.isHidden = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketCell.cellIdentifier(), for: indexPath)
        let homeBucketData = homeViewModel.homeTableViewModel.value[indexPath.row]
        if let cell = cell as? CellConfigurable{
        cell.setup(viewModel: homeBucketData)
        }
        return cell
    }
}

//MARK: - UITableView Delegate
extension HomeVC : UITableViewDelegate {
    
}


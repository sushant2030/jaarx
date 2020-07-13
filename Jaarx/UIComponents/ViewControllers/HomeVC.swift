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
        homeTableView.register(UINib.init(nibName: "BucketCell", bundle: nil), forCellReuseIdentifier: "BucketCell")
    }
    
    func bindData(){
        homeViewModel.homeData.addObserver(fireNow: false) { [weak self] (homeResponse) in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
        }
    }
}

//MARK: - UITableView DataSource
extension HomeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let homeBucketData = homeViewModel.homeData.value[indexPath.row]
        let bucketType = homeBucketData.bucketType
        switch bucketType {
        case .carousel,.banner,.scanAndOrder,.hotcuisins:
            return 150
        case .hashtags:
            return 100
        default:
            return 250
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let count = self.homeViewModel.homeData.value.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BucketCell = tableView.dequeueReusableCell(withIdentifier: "BucketCell", for: indexPath) as! BucketCell
        let homeBucketData = homeViewModel.homeData.value[indexPath.row]
        
        cell.bucketType = homeBucketData.bucketType
        switch cell.bucketType {
        case .hotcuisins:
            cell.backgroundColor = .blue
        default:
            cell.backgroundColor = .red
        }
        cell.setup(viewModel: homeBucketData)
        return cell
    }
}

//MARK: - UITableView Delegate
extension HomeVC : UITableViewDelegate {
    
}


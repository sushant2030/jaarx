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
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDelegateAndDataSource()
        // Do any additional setup after loading the view.
    }
    
    func registerDelegateAndDataSource() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib.init(nibName: "BucketCell", bundle: nil), forCellReuseIdentifier: "BucketCell")
    }
}

//MARK: - UITableView DataSource
extension HomeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BucketCell = tableView.dequeueReusableCell(withIdentifier: "BucketCell", for: indexPath) as! BucketCell
        return cell
    }
}

//MARK: - UITableView Delegate
extension HomeVC : UITableViewDelegate {
    
}


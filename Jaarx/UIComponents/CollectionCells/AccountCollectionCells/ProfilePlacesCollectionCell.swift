//
//  ProfilePlacesCollectionCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 31/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class ProfilePlacesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var profileTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerViews()
    }
    
    func registerViews() {
           profileTableView.delegate = self
           profileTableView.dataSource = self
           profileTableView.register(UINib.init(nibName: RestaurantListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantListCell.cellIdentifier())
       }

}

extension ProfilePlacesCollectionCell : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellIdentifier(), for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

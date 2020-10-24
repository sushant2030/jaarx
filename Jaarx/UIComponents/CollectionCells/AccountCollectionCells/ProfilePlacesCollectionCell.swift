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
    var restaurantsVM : [RestaurantCellVM]?
    
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
    func reloadData()  {
        self.profileTableView.reloadData()
    }
}
extension ProfilePlacesCollectionCell : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsVM?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resVM = restaurantsVM?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable{
            cell.setup(viewModel: resVM!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let resVM = restaurantsVM?[indexPath.row]{
            resVM.cellPressed?()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BucketCellHeight.large.rawValue
    }
    
}

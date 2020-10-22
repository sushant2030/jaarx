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
    let favoriteRestaurantsVM = FavoriteRestaurantsVM()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerViews()
        self.favoriteRestaurantsVM.getFavoriteRestaurantsForUser(userId: "e74996b1-22c4-43a3-886c-2ddc9763f798")
        self.bindData()
    }
    func bindData(){
        favoriteRestaurantsVM.favoriteRestaurantVM.addObserver(fireNow: false) { [weak self] (favoriteRestaurantVM) in
            DispatchQueue.main.async {
                self?.profileTableView.reloadData()
            }
        }
    }
    func registerViews() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib.init(nibName: RestaurantListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RestaurantListCell.cellIdentifier())
    }
}
extension ProfilePlacesCollectionCell : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRestaurantsVM.favoriteRestaurantVM.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favResVM = favoriteRestaurantsVM.favoriteRestaurantVM.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable{
            cell.setup(viewModel: favResVM)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

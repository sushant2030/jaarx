//
//  RestaurantDetailViewHeader.swift
//  Jaarx
//
//  Created by Sumit Kumar on 25/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class RestaurantDetailViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    @IBOutlet weak var restaurantCuisineLabel: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var timingLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var openDaysLabel: UILabel!
    
    var tagCollection : [String]?
    static let reuseIdentifier: String = String(describing: self)
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        registerViews()
    
    }
    override func layoutSubviews() {
        configureRatingContainerView()
    }
    func registerViews()  {
        tagCollectionView.register(UINib.init(nibName:TagCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: TagCollectionCell.cellIdentifier())
        tagCollectionView.dataSource = self
    }
    func configureRatingContainerView(){
        ratingContainerView.dropShadow()
        ratingContainerView.layer.cornerRadius = 10
        ratingContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    func configureHeaderViewWith(headerVM:HeaderViewModel) {
        if let imageUrl = headerVM.imageUrl{
        self.restaurantImageView.downloaded(from:imageUrl)
        }
        self.tagCollection = headerVM.tagCollection
        self.ratingLabel.text = headerVM.rating
        self.restaurantNameLabel.text = headerVM.restaurantName
        self.restaurantLocationLabel.text = headerVM.restaurantLocationText
        self.restaurantCuisineLabel.text = headerVM.restaurantCuisineText
        self.timingLabel.text = headerVM.timingText
        self.priceRangeLabel.text = headerVM.priceRangeText
        self.openDaysLabel.text = headerVM.openDaysText
        self.tagCollectionView.reloadData()
    }
}

extension RestaurantDetailViewHeader : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagCollection?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.cellIdentifier() , for: indexPath) as? TagCollectionCell
        cell?.tagLabel.text = self.tagCollection?[indexPath.item]
        return cell!
    }
}

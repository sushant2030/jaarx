//
//  BucketCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 04/03/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit


class BucketCell: UITableViewCell{
    
    @IBOutlet weak var bucketTitleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerCollectionView: UICollectionView!
    @IBOutlet weak var bucketDescriptionLabel: UILabel!
    @IBOutlet weak var bucketTitleLabel: UILabel!
    var restaurantViewModel : RestaurantViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        registerViews()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.restaurantViewModel = nil
    }
    
    func registerViews()  {
        containerCollectionView.register(UINib.init(nibName: CarouselCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: CarouselCell.cellIdentifier())
        containerCollectionView.register(UINib.init(nibName: LongCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: LongCollectionCell.cellIdentifier())
        containerCollectionView.register(UINib.init(nibName: SquareCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: SquareCollectionCell.cellIdentifier())
        containerCollectionView.register(UINib.init(nibName: HorizontalListCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: HorizontalListCollectionCell.cellIdentifier())
        containerCollectionView.delegate = self
        containerCollectionView.dataSource = self
    }
    
    private func reload()  {
        containerCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension BucketCell : CellConfigurable {
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = (viewModel as? HomeRowVM) else {return}
        self.restaurantViewModel = RestaurantViewModel.init(homeBucketVM: viewModel)
        bucketTitleViewHeight.constant = viewModel.bucketTitleViewHeight
        self.backgroundColor = viewModel.backgroundColor
        self.bucketTitleLabel.text = viewModel.title
        reload()
    }
    
}

extension BucketCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantViewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantVM = self.restaurantViewModel
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (self.restaurantViewModel?.cellIdentifier())! , for: indexPath)
        if let cell = cell as? CellConfigurable{
            if (restaurantVM?.restaurantCollectionVM.count)!>0{
                if let restaurantCellVM = restaurantVM?.restaurantCollectionVM[indexPath.row]{
                    cell.setup(viewModel: restaurantCellVM)
                }
            }
            else{
                if let homeRowVM = restaurantVM?.homeRowVM {
                    cell.setup(viewModel:homeRowVM )
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.bounds.width - 60) / 3
        switch self.restaurantViewModel?.bucketType {
        case .banner,.carousel,.scanAndOrder:
            return CGSize.init(width: self.bounds.size.width - 30, height: self.bounds.size.height)
        case .hotcuisins:
            return CGSize.init(width: width, height: width)
        case .hashtags:
            return CGSize.init(width: 100, height: 50)
        default:
            return CGSize.init(width: width, height: (width * 2))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch self.restaurantViewModel?.bucketType {
        case .banner,.carousel,.scanAndOrder:
            return 0
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch self.restaurantViewModel?.bucketType {
        case .banner,.carousel:
            return UIEdgeInsets.init(top: 10, left: 15, bottom: 20, right: 15)
        case .scanAndOrder:
            return UIEdgeInsets.init(top: 20, left: 15, bottom: 10, right: 15)
        default:
            return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
}

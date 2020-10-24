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
    @IBOutlet weak var seeAllButton: UIButton!
    var restaurantViewModel : RestaurantViewModel?
    var viewModel : HomeRowVM?
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
        containerCollectionView.register(UINib.init(nibName: LongCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: LongCollectionCell.cellIdentifier())
        containerCollectionView.register(UINib.init(nibName: SquareCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: SquareCollectionCell.cellIdentifier())
        containerCollectionView.register(UINib.init(nibName: TagCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: TagCollectionCell.cellIdentifier())
        containerCollectionView.delegate = self
        containerCollectionView.dataSource = self
    }
    
    @IBAction func seeAllButtonAction(_ sender: UIButton) {
        self.viewModel?.seeAllButtonAction?()
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
        self.viewModel = viewModel
        self.restaurantViewModel = viewModel.restaurantViewModel
        self.backgroundColor = viewModel.backgroundColor
        self.bucketTitleLabel.text = viewModel.title
        reload()
    }
    
}

extension BucketCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantViewModel?.restaurantCollectionVM.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantVM = self.restaurantViewModel
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (self.restaurantViewModel?.cellIdentifier())! , for: indexPath)
        if let cell = cell as? CellConfigurable {
            if (restaurantVM?.restaurantCollectionVM.value.count)!>0 {
                if let restaurantCellVM = restaurantVM?.restaurantCollectionVM.value[indexPath.row]{
                    cell.setup(viewModel: restaurantCellVM)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurantVM = self.restaurantViewModel
        if (restaurantVM?.restaurantCollectionVM.value.count)!>0 {
            if let restaurantCellVM = restaurantVM?.restaurantCollectionVM.value[indexPath.row] {
                restaurantCellVM.cellPressed?()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (restaurantViewModel?.getGridSize(self.bounds))!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return restaurantViewModel!.minimumLineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return restaurantViewModel!.edgeInset
    }
}

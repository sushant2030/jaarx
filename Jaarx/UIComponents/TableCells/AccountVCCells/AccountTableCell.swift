//
//  AccountTableCell.swift
//  Jaarx
//
//  Created by Sumit Kumar on 30/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class AccountTableCell: UITableViewCell  {
    
    @IBOutlet weak var accountViewCollectionCell: UICollectionView!
    var currentPage : Int = 0
    var accountCollectionCurrentPage : ((Int) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        registerViews()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func registerViews()  {
        accountViewCollectionCell.register(UINib.init(nibName: ProfilePlacesCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: ProfilePlacesCollectionCell.cellIdentifier())
        accountViewCollectionCell.register(UINib.init(nibName: ProfileSettingCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: ProfileSettingCollectionCell.cellIdentifier())
        accountViewCollectionCell.delegate = self
        accountViewCollectionCell.dataSource = self
    }
    
    private func reload()  {
        accountViewCollectionCell.reloadData()
        
    }
}

extension AccountTableCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell
        switch indexPath.item {
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: (ProfileSettingCollectionCell.cellIdentifier()) , for: indexPath)
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: (ProfilePlacesCollectionCell.cellIdentifier()) , for: indexPath)
        }
        return cell
    }
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: contentView.frame.width, height: contentView.frame.height)
        
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            currentPage = scrollView.currentPage
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = scrollView.currentPage
        accountCollectionCurrentPage?(currentPage)
    }
}

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width) + 1    }
}

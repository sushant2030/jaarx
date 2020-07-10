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
    var homeData:HomeBucketViewModel?
    var bucketType : BucketType!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerViews()
        // Initialization code
        
    }
    
    func registerViews()  {
        containerCollectionView.register(UINib.init(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        containerCollectionView.register(UINib.init(nibName: "LongCollectionCell", bundle: nil), forCellWithReuseIdentifier: "LongCollectionCell")
        containerCollectionView.register(UINib.init(nibName: "SquareCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SquareCollectionCell")
        containerCollectionView.register(UINib.init(nibName: "HorizontalListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalListCollectionCell")
        containerCollectionView.delegate = self
        containerCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BucketCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        homeData = (viewModel as! HomeBucketViewModel)
        switch bucketType! {
        case .banner,.carousel,.scanAndOrder:
            bucketTitleViewHeight.constant = 0
        default:
            bucketTitleViewHeight.constant = 50
            self.bucketTitleLabel.text = homeData?.title ?? ""
        }
    }
    
    
}


extension BucketCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch bucketType {
        case .carousel,.banner,.scanAndOrder:
            return 1
        default:
            let count = homeData?.data?.count ?? 0
            return count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch bucketType {
        case .banner,.carousel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
            return cell
        case .scanAndOrder:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
            return cell
        case .critics,.mostscanned,.newlyOpened,.topPicks:
            let restData = homeData?.data![indexPath.row] ?? nil
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LongCollectionCell", for: indexPath) as? LongCollectionCell
            cell?.setRestData(restaurantData:restData!)
            return cell!
        case .hotcuisins:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareCollectionCell", for: indexPath)
            return cell
        case .hashtags:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalListCollectionCell", for: indexPath)
            return cell
        case .none:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "None", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch bucketType {
        case .banner,.carousel,.scanAndOrder:
            return CGSize.init(width: self.bounds.size.width, height: 100)
        case .hotcuisins:
            return CGSize.init(width: 100, height: 100)
        case .hashtags:
            return CGSize.init(width: 100, height: 50)
        default:
            return CGSize.init(width: 100, height: self.bounds.size.height)
        }
    }
    
    
}

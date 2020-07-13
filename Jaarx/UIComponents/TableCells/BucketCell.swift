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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.homeData = nil
    }
    
    func registerViews()  {
        containerCollectionView.register(UINib.init(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        containerCollectionView.register(UINib.init(nibName: "LongCollectionCell", bundle: nil), forCellWithReuseIdentifier: "LongCollectionCell")
        containerCollectionView.register(UINib.init(nibName: "SquareCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SquareCollectionCell")
        containerCollectionView.register(UINib.init(nibName: "HorizontalListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalListCollectionCell")
        containerCollectionView.delegate = self
        containerCollectionView.dataSource = self
    }
    
    private func reload()  {
        containerCollectionView.reloadData()
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
        reload()
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
            if let imageUrl = URL.init(string:"https://www.bootstrapdash.com/wp-content/uploads/2019/09/best-selling-restaurant-website-templates-1.gif"){
                cell.carouselImage.downloaded(from: imageUrl)
            }
            return cell
        case .scanAndOrder:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
            if let imageUrl = URL.init(string:"https://cdn.crn.in/wp-content/uploads/2020/05/25105053/M2.png"){
                cell.carouselImage.downloaded(from: imageUrl)
            }
            return cell
        case .critics,.mostscanned,.newlyOpened,.topPicks:
            let restData = homeData?.data![indexPath.row] ?? nil
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LongCollectionCell", for: indexPath) as? LongCollectionCell
            cell?.setRestData(restaurantData:restData!)
            return cell!
        case .hotcuisins:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareCollectionCell", for: indexPath) as! SquareCollectionCell
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
        let width = (self.bounds.width - 60) / 3
        switch bucketType {
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
        switch bucketType {
        case .banner,.carousel,.scanAndOrder:
            return 0
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch bucketType {
        case .banner,.carousel:
            return UIEdgeInsets.init(top: 10, left: 15, bottom: 20, right: 15)
        case .scanAndOrder:
            return UIEdgeInsets.init(top: 20, left: 15, bottom: 10, right: 15)
        default:
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
}

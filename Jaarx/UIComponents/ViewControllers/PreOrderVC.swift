//
//  PreOrderVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class PreOrderVC: UIViewController {

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var tableImageView: UIImageView!
    let preOrderVM = PreOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViews()
        // Do any additional setup after loading the view.
    }
    
    func registerViews()  {
        peopleCollectionView.register(UINib.init(nibName: RoundCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: RoundCollectionCell.cellIdentifier())
        dayCollectionView.register(UINib.init(nibName: RoundCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: RoundCollectionCell.cellIdentifier())
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PreOrderVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionCell.cellIdentifier(), for: indexPath) as! RoundCollectionCell
        cell.setup()
        cell.deSelect()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RoundCollectionCell
        cell.selectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RoundCollectionCell
        cell.deSelect()
    }
    
    
}

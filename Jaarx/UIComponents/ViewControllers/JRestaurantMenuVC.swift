//
//  JRestaurantMenuVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JRestaurantMenuVC: UIViewController {

    @IBOutlet weak var lblTotalCost: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    let menuViewModel = MenuViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViews()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func registerViews()  {
        menuCollectionView.register(UINib.init(nibName: MenuCategoryPageCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: MenuCategoryPageCell.cellIdentifier())
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        headerCollectionView.register(UINib.init(nibName: MenuHeaderCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: MenuHeaderCell.cellIdentifier())
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        setNavigationBar(WithTitle: "Menu")
    }
    func setRestaurantId(resId : String, name : String) {
        menuViewModel.getRestaurantMenu(resId: resId)
        self.navigationController?.title = name
    }
    
    func bindData()  {
        menuViewModel.cuisineCategories.addObserver(fireNow: false) { (categories) in
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
                self.headerCollectionView.reloadData()
            }
        }
        UserDataSource.sharedInstance.carts.addObserver(fireNow: false) { [weak self] (carts) in
            DispatchQueue.main.async {
                self?.lblItemCount.text = "\(carts.count) Items"
                let count = carts.reduce(0) { (result, cart)  in
                    result + Int((cart.dishPrice)!)!
                }
                self?.lblTotalCost.text = "Total " + "\(count)"
            }
        }
        menuViewModel.currentMenuPage.addObserver(fireNow: false) { (page) in
            DispatchQueue.main.async {
                self.menuCollectionView.scrollToItem(at: page, at: .left, animated: true)
                self.headerCollectionView.selectItem(at: page, animated: false, scrollPosition: .centeredVertically)
            }
        }
    }
    
    // MARK: - IBOutlets
    
    @IBAction func actionConfirm(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 2
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

extension JRestaurantMenuVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuViewModel.cuisineCategories.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuViewModel.cellIdentifier(collectionViewType: (collectionView == menuCollectionView) ? .menu : .header), for: indexPath)
        let categoryDetail = menuViewModel.cuisineCategories.value[indexPath.row]
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: categoryDetail)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return menuViewModel.getCellSize(collectionView: collectionView, collectionViewType: (collectionView == menuCollectionView) ? .menu : .header, indexPath : indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuViewModel.currentMenuPage.value = indexPath
        if let cell  = collectionView.cellForItem(at: indexPath) as? MenuHeaderCell {
            let model = self.menuViewModel.cuisineCategories.value[indexPath.item]
            model.isSelected = true
            cell.setSelection(isSelected:true)
        }
        self.headerCollectionView.reloadData()
        
    }
                      
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

         let model = self.menuViewModel.cuisineCategories.value.filter({ $0.isSelected == true})
        if model.count > 0 {
            model[0].isSelected = false
        }
            
        
    }
    
}

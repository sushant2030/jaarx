//
//  MenuCategoryPageCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class MenuCategoryPageCell: UICollectionViewCell {

    @IBOutlet weak var menuTableView: UITableView!
    var cellVM : CategoryDetailVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerViews()
        // Initialization code
    }
    
    func registerViews()  {
        menuTableView.register(UINib.init(nibName:  MenuTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier:  MenuTableCell.cellIdentifier())
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }

}

extension MenuCategoryPageCell : CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? CategoryDetailVM {
            cellVM = viewModel
            menuTableView.reloadData()
        }
    }
}

extension MenuCategoryPageCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM?.foodDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.cellIdentifier(), for: indexPath)
        let foodDetail = cellVM.foodDetails[indexPath.row]
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: foodDetail)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

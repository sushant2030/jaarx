//
//  MenuHeaderCell.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class MenuHeaderCell: UICollectionViewCell {

    @IBOutlet weak var underLinedView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    var headerVM : CategoryDetailVM?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension MenuHeaderCell: CellConfigurable {
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? CategoryDetailVM {
            headerVM = viewModel
            lblTitle.text = viewModel.cuisineCategoryName!
            self.setSelection(isSelected: headerVM?.isSelected ?? false)
        }
    }
    
    func setSelection(isSelected : Bool)  {
        
        self.underLinedView.backgroundColor = isSelected ? .black : .clear
        
    }
    
    
}

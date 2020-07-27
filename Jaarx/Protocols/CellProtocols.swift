//
//  CellConfigurable.swift
//  Jaarx
//
//  Created by Sushant Alone on 03/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit
protocol CellConfigurable {
    func setup(viewModel: RowViewModel) // Provide a generic function for table row set up
}
protocol RowViewModel {
}
protocol ViewModelPressible {
    var cellPressed: (()->Void)? { get set }
}

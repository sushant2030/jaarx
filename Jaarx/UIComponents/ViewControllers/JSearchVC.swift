//
//  JSearchVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 18/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JSearchVC: UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViews()
        bindData()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func registerViews() {
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib.init(nibName: SearchTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: SearchTableCell.cellIdentifier())
    }
    
    func bindData() {
        searchViewModel.searchData.addObserver(fireNow: false) { [weak self] (searchVMS) in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
                self?.searchTableView.isHidden = false
                for searchVM in searchVMS{
                    searchVM.cellButtonAction = self?.handleCellButtonAction(searchVM: searchVM)
                }
            }
        }
    }
    
    func handleCellButtonAction(searchVM : SearchData) -> ((CellAction) -> Void)  {
        
         return { [weak self, weak searchVM] action in
            switch action {
            case .preOrder:
                self?.navigateToQRCodeScannerVC(restaurantId: searchVM?.id ?? "")
            case .scan:
                self?.navigateToQRCodeScannerVC(restaurantId: searchVM?.id ?? "")
            }
        }
        
    }
    
    
    
    func navigateToQRCodeScannerVC(restaurantId:String) {
        if let qrCodeScannerVC = UIStoryboard.qrCodeScannerVC(){
            self.navigationController?.pushViewController(qrCodeScannerVC, animated: true)
        }
    }


}

extension JSearchVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.searchData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.cellIdentifier(), for: indexPath)
        let searchData = searchViewModel.searchData.value[indexPath.row]
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: searchData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchViewModel.rowHeight
    }
    
}

extension JSearchVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.getSearchData(searchText: searchBar.text ?? "")
    }
    
}

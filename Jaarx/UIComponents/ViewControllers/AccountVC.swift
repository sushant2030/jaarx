//
//  AccountVC.swift
//  Jaarx
//
//  Created by Sumit Kumar on 26/08/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
         self.registerDelegateAndDataSource()
    }
    func registerDelegateAndDataSource() {
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        //        self.accountTableView.register(
        //            AccountTableViewHeader.nib,
        //            forHeaderFooterViewReuseIdentifier:
        //            AccountTableViewHeader.reuseIdentifier
        //        )
        accountTableView.register(UINib.init(nibName: AccountTableCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: AccountTableCell.cellIdentifier())
        if let view = AccountHeaderView.instanceFromNib() as? AccountHeaderView{
            accountTableView.tableHeaderView = view
            view.buttonAction = {sender in
                self.headerViewButtonAction(sender: sender)
            }
        }
        
    }
    func bindData(){
    }
    func headerViewButtonAction(sender:UIButton)   {
        if let cell = accountTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? AccountTableCell{
            cell.accountViewCollectionCell .scrollToItem(at: IndexPath.init(item: sender.tag-1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func accountCollectionCellScrolledPage(page:Int)   {
//        guard let view = accountTableView.dequeueReusableHeaderFooterView(
//            withIdentifier: AccountTableViewHeader.reuseIdentifier)
//            as? AccountTableViewHeader
//            else {return}
//        view.hightLightSelectedViewWithTag(tag: page)
        if let view = accountTableView.tableHeaderView as? AccountHeaderView{
                    view.hightLightSelectedViewWithTag(tag: page)
               }
    }
}

extension AccountVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.containerView.frame.height - (self.accountTableView.tableHeaderView?.frame.height)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AccountTableCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? AccountTableCell
        {
            cell.accountCollectionCurrentPage = { page in
                self.accountCollectionCellScrolledPage(page: page)
            }
        }
        return cell
    }
    
}

extension AccountVC: UITableViewDelegate {
    
    //    func tableView(_ tableView: UITableView,
    //                   viewForHeaderInSection section: Int) -> UIView? {
    //        guard let view = tableView.dequeueReusableHeaderFooterView(
    //            withIdentifier: AccountTableViewHeader.reuseIdentifier)
    //            as? AccountTableViewHeader
    //            else {return nil}
    //        view.buttonAction = {sender in
    //            self.headerViewButtonAction(sender: sender)
    //        }
    //        return view
    //    }
//        func tableView(_ tableView: UITableView,
//                       heightForHeaderInSection section: Int) -> CGFloat {
//            return  365.0
//        }
}

//
//  JEditCartVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 20/09/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class JEditCartVC: UIViewController {
    let editCartVM = EditCartViewModel()
    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func registerView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib.init(nibName: editCartVM.getEditCartIdentifier(), bundle: nil), forCellReuseIdentifier: editCartVM.getEditCartIdentifier())
    }
    
    func bindData()  {
        editCartVM.carts.addObserver(fireNow: true) { [weak self] (carts) in
            DispatchQueue.main.async {
                self?.cartTableView.reloadData()
            }
        }
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func actionPlaceOrder(_ sender: UIButton) {
        CartDataSource.sharedCart.addCart()
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


extension JEditCartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = CartDataSource.sharedCart.carts.value.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editCartVM.getEditCartIdentifier(), for: indexPath)
        let cart = editCartVM.carts.value[indexPath.item]
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: cart)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
}

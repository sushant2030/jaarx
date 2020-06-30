//
//  SignUpVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 29/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(UINib.init(nibName: "JTextFieldCell", bundle: nil), forCellReuseIdentifier: "JTextFieldCell")
        infoTableView.separatorColor = UIColor.clear
        infoTableView.makeViewCornerRadiusWithRadi(radius: 10.0)
        btnRegister.makeCornerRadiusWithRadi(radius: 15.0)
        // Do any additional setup after loading the view.
    }
        // MARK: - IBAction
    @IBAction func sctionRegister(_ sender: UIButton) {
        
    }
    
    @IBAction func actionSignIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

extension SignUpVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JTextFieldCell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.size.height/4
        return height
    }
}

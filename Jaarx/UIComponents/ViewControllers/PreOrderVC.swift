//
//  PreOrderVC.swift
//  Jaarx
//
//  Created by Sushant Alone on 26/07/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import UIKit

class PreOrderVC: UIViewController {

    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var pickerHoldingView: UIView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var amView: UIView!
    @IBOutlet weak var pmView: UIView!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var minuteView: UIView!
    @IBOutlet weak var btnHour: UIButton!
    @IBOutlet weak var btnMinute: UIButton!
    @IBOutlet weak var btnAM: UIButton!
    @IBOutlet weak var btnPM: UIButton!
    var preOrderVM = PreOrderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViews()
        bindDate()
        preOrderVM.changeStartDate(date: Date())
        // Do any additional setup after loading the view.
    }
    
    func registerViews()  {
        peopleCollectionView.register(UINib.init(nibName: RoundCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: RoundCollectionCell.cellIdentifier())
        dayCollectionView.register(UINib.init(nibName: RoundCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: RoundCollectionCell.cellIdentifier())
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        pickerHoldingView.makeViewCornerRadiusWithRadi(radius: 5)
        pickerHoldingView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        btnMinute.makeViewCornerRadiusWithRadi(radius: btnMinute.frame.size.height / 2)
        btnMinute.makeAppThemeColorBorder()
        
        btnHour.makeViewCornerRadiusWithRadi(radius: btnMinute.frame.size.height / 2)
        btnHour.makeAppThemeColorBorder()
        
        
        btnAM.makeViewCornerRadiusWithRadi(radius: 25/2)
        btnAM.makeAppThemeColorBorder()
        
        btnPM.makeViewCornerRadiusWithRadi(radius: 25/2)
        btnPM.makeAppThemeColorBorder()
    }
    
    func bindDate()  {
        preOrderVM.requiredDates.addObserver(fireNow: false) { [weak self] (day) in
            DispatchQueue.main.async {
                self?.btnDate.setTitle(Date.getSpelledDate(date: self?.preOrderVM.startDate ?? Date()), for: .normal)
                self?.dayCollectionView.reloadData()
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func actionDateChange(_ sender: UIButton) {
        pickerHoldingView.isHidden = false
        
    }
    @IBAction func actionReserve(_ sender: UIButton) {
    }
    // MARK: - IBOutlets
    
    @IBAction func actionPicker(_ sender: UIButton) {
        preOrderVM.changeStartDate(date: picker.date)
        pickerHoldingView.isHidden = true
    }
    
    
    

}

extension PreOrderVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == peopleCollectionView {
            return 10
        } else {
            return preOrderVM.requiredDates.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundCollectionCell.cellIdentifier(), for: indexPath) as! RoundCollectionCell
        if collectionView == peopleCollectionView {
            cell.setTableNumber(tableNumber: indexPath.row + 1)
        } else {
            let dateDetails = preOrderVM.requiredDates.value[indexPath.row]
            cell.setDate(date: dateDetails)
        }
        cell.setup()
        cell.deSelect()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RoundCollectionCell
        if let cell = cell {
            cell.selectCell()
        }
        if collectionView == dayCollectionView {
            preOrderVM.bookingDate = Date.getDateInString(date: preOrderVM.requiredDates.value[indexPath.row].date)
        } else {
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RoundCollectionCell
        if let cell = cell {
            cell.deSelect()
        }
    }
    
    
}




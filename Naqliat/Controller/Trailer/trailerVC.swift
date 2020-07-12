//
//  trailerVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class trailerVC: UIViewController {
    
    @IBOutlet weak var addressTo: textFieldView!
    @IBOutlet weak var addressForm: textFieldView!
    @IBOutlet weak var dateAndTime: textFieldView!
    @IBOutlet weak var selctedBtn: UIButton!
    @IBOutlet weak var notoTF: textFieldView!
    @IBOutlet weak var carTypeTF: textFieldView!
    @IBOutlet weak var carTypeView: UIView!
    
    var now = "1"
    
    var fromLat = 0.0
    var fromLong = 0.0
    
    var toLat = 0.0
    var toLong = 0.0
    
    var fromBtn = 0
    var toBtn = 0
    
    var type = ""
    var name = ""
    
    private var datePiker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePiker()
        setUpNavColore(false, name)
        if type == "flat_truck" {
            carTypeTF.isHidden = false
            carTypeView.isHidden = false
        }
        
    }
    
    func createDatePiker(){
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .dateAndTime
        datePiker?.addTarget(self, action: #selector(dateVC.dateChanged(datePiker:)), for: .valueChanged)
        dateAndTime.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateAndTime.text = dateFormater.string(from: datePiker.date)
    }
    
    
    @IBAction func sendBtn(_ sender: Any) {
        requestsApi.makeOrderApi(order_type: type, from_number_of_rooms: "", from_floor: "", from_elevator: "", from_type_of_house: "", from_notes: notoTF.text ?? "", from_other_notes: notoTF.text ?? "", from_lat: "\(fromLat)", from_lng: "\(fromLong)", from_address: addressForm.text ?? "", to_number_of_rooms: "", to_floor: "", to_elevator: "", to_type_of_house: "", to_notes: notoTF.text ?? "", to_other_notes: notoTF.text ?? "", to_lat: "\(toLat)", to_lng: "\(toLong)", to_address: addressTo.text ?? "", date_work: dateAndTime.text ?? "", car_type: carTypeTF.text ?? "", parameterss: [], requestType: "create") { (error, success, message) in
            if success {
                let vc = suceessVC(nibName: "suceessVC", bundle: nil)
                vc.fromTrailer = 1
                self.navigationController!.pushViewController(vc, animated: false)
            }
        }
    }
    
    
    @IBAction func selectedBtnAction(_ sender: Any) {
        if now == "1" {
            now = "2"
            selctedBtn.setImage(UIImage(named: "Group 1468"), for: .normal)
        }else if now == "2" {
            now = "1"
            selctedBtn.setImage(UIImage(named: "Group 14468"), for: .normal)
        }
    }
    
    
    @IBAction func toBtn(_ sender: Any) {
        toBtn = 1
        let vc = serachAddressVC(nibName: "serachAddressVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func fromBtn(_ sender: Any) {
        fromBtn = 1
        let vc = serachAddressVC(nibName: "serachAddressVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
}

extension trailerVC: saveTheAddress {
    func saveAdderssInfo(address: String, lat: Double, long: Double) {
        if fromBtn == 1 {
            fromBtn = 0
            print("from\(lat)")
            fromLat = lat
            fromLong = long
            self.addressForm.text = address
        }else if toBtn == 1 {
            toBtn = 0
            print("to\(lat)")
            toLat = lat
            toLong = long
            self.addressTo.text = address
            
        }
    }
    
    
}

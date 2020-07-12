//
//  toVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class toVC: UIViewController {
    
    @IBOutlet weak var toAddressTF: textFieldView!
    @IBOutlet weak var toTypeeOfHouseTF: textFieldView!
    @IBOutlet weak var toNumOFRoom: textFieldView!
    @IBOutlet weak var toFloor: textFieldView!
    @IBOutlet weak var toLiftAvaliabilty: UIButton!
    @IBOutlet weak var toNotes: textFieldView!
    
    
    var fromAddressTF = ""
    var formTypeeOfHouseTF = ""
    var fromNumOFRoom = ""
    var fromFloor = ""
    var fromLiftAvaliabilty = ""
    var fromNotes = ""
    var fromLat = 0.0
    var fromLong = 0.0
    
    var toLift = "1"
    var toLat = 0.0
    var toLong = 0.0
    
    var typeeOfHouseArray = ["vella","flat","building"]
    
    let numOfRoomPickerView = UIPickerView()
    let floorPickerView = UIPickerView()
    let typeeOfHousePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "Furniture transfer")
        setUpNav(menu: false, notification: true,back: false)
        
        creatNumOfRoomPiker()
        creatFloorPiker()
        creatTypeeOfHousePickerViewPiker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    func creatNumOfRoomPiker() {
        numOfRoomPickerView.delegate = self
        numOfRoomPickerView.dataSource = self
        toNumOFRoom.inputView = numOfRoomPickerView
        self.numOfRoomPickerView.reloadAllComponents()
    }
    
    
    func creatFloorPiker() {
        floorPickerView.delegate = self
        floorPickerView.dataSource = self
        toFloor.inputView = floorPickerView
        self.floorPickerView.reloadAllComponents()
    }
    
    func creatTypeeOfHousePickerViewPiker() {
        typeeOfHousePickerView.delegate = self
        typeeOfHousePickerView.dataSource = self
        toTypeeOfHouseTF.inputView = typeeOfHousePickerView
        self.typeeOfHousePickerView.reloadAllComponents()
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        let vc = furnitureTypeVC(nibName: "furnitureTypeVC", bundle: nil)
        vc.fromAddressTF = fromAddressTF
        vc.formTypeeOfHouseTF = formTypeeOfHouseTF
        vc.fromNumOFRoom = fromNumOFRoom
        vc.fromFloor = fromFloor
        vc.fromLiftAvaliabilty = fromLiftAvaliabilty
        vc.fromNotes = fromNotes
        vc.fromLat = fromLat
        vc.fromLong = fromLong
        
        vc.toAddressTF = toAddressTF.text ?? ""
        vc.toTypeeOfHouseTF = toTypeeOfHouseTF.text ?? ""
        vc.toNumOFRoom = toNumOFRoom.text ?? ""
        vc.toFloor = toFloor.text ?? ""
        vc.toLiftAvaliabilty = toLift
        vc.toNotes = toNotes.text ?? ""
        vc.toLat = toLat
        vc.toLong = toLong
        
        self.navigationController!.pushViewController(vc, animated: false)
    }
    
    @IBAction func openMap(_ sender: Any) {
        let vc = serachAddressVC(nibName: "serachAddressVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    @IBOutlet weak var openMap: NSLayoutConstraint!
    @IBAction func liftBTNAction(_ sender: Any) {
        if toLift == "1" {
            toLift = "2"
            toLiftAvaliabilty.setImage(UIImage(named: "Group 1468"), for: .normal)
        }else if toLift == "2" {
            toLift = "1"
            toLiftAvaliabilty.setImage(UIImage(named: "Group 14468"), for: .normal)
        }
    }
    
}


extension toVC: saveTheAddress {
    func saveAdderssInfo(address: String, lat: Double, long: Double) {
        print("to\(lat)")
        toLat = lat
        toLong = long
        self.toAddressTF.text = address
    }
    
    
}

extension toVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == numOfRoomPickerView{
            return URLs.numbersArray.count
        }else if pickerView == floorPickerView{
            return URLs.numbersArray.count
        }else {
            return typeeOfHouseArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == numOfRoomPickerView{
            return URLs.numbersArray[row]
        }else if pickerView == floorPickerView{
            return URLs.numbersArray[row]
        }else {
            return typeeOfHouseArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == numOfRoomPickerView{
            toNumOFRoom.text = URLs.numbersArray[row]
        }else if pickerView == floorPickerView{
            toFloor.text = URLs.numbersArray[row]
        }else {
            toTypeeOfHouseTF.text = typeeOfHouseArray[row]
        }
    }
}

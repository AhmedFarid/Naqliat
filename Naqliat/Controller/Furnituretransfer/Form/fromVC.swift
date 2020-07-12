//
//  fromVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class fromVC: UIViewController {

    @IBOutlet weak var fromAddressTF: textFieldView!
    @IBOutlet weak var typeeOfHouseTF: textFieldView!
    @IBOutlet weak var fromNumOFRoom: textFieldView!
    @IBOutlet weak var fromFloor: textFieldView!
    @IBOutlet weak var fromLiftAvaliabilty: UIButton!
    @IBOutlet weak var notesTF: textFieldView!
    
    var formLift = "1"
    var fromLat = 0.0
    var fromLong = 0.0
    var typeeOfHouseArray = ["vella","flat","building"]
    
    let numOfRoomPickerView = UIPickerView()
    let floorPickerView = UIPickerView()
    let typeeOfHousePickerView = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "Furniture transfer")
        setUpNav(menu: false, notification: true)
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
        fromNumOFRoom.inputView = numOfRoomPickerView
        self.numOfRoomPickerView.reloadAllComponents()
    }
    
    
    func creatFloorPiker() {
        floorPickerView.delegate = self
        floorPickerView.dataSource = self
        fromFloor.inputView = floorPickerView
        self.floorPickerView.reloadAllComponents()
    }
    
    func creatTypeeOfHousePickerViewPiker() {
        typeeOfHousePickerView.delegate = self
        typeeOfHousePickerView.dataSource = self
        typeeOfHouseTF.inputView = typeeOfHousePickerView
        self.typeeOfHousePickerView.reloadAllComponents()
    }

    @IBAction func liftBTNAction(_ sender: Any) {
        if formLift == "1" {
            formLift = "2"
            fromLiftAvaliabilty.setImage(UIImage(named: "Group 1468"), for: .normal)
        }else if formLift == "2" {
            formLift = "1"
            fromLiftAvaliabilty.setImage(UIImage(named: "Group 14468"), for: .normal)
        }
    }
    
    @IBAction func mapBtn(_ sender: Any) {
        let vc = serachAddressVC(nibName: "serachAddressVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    @IBAction func nextBtn(_ sender: Any) {
        let vc = toVC(nibName: "toVC", bundle: nil)
        vc.fromAddressTF = fromAddressTF.text ?? ""
        vc.formTypeeOfHouseTF = typeeOfHouseTF.text ?? ""
        vc.fromNumOFRoom = fromNumOFRoom.text ?? ""
        vc.fromFloor = fromFloor.text ?? ""
        vc.fromLiftAvaliabilty = formLift
        vc.fromNotes = notesTF.text ?? ""
        vc.fromLat = fromLat
        vc.fromLong = fromLong
        self.navigationController!.pushViewController(vc, animated: false)
    }
    

}

extension fromVC: saveTheAddress {
    func saveAdderssInfo(address: String, lat: Double, long: Double) {
        print("from\(lat)")
        fromLat = lat
        fromLong = long
        self.fromAddressTF.text = address
    }
    
    
}


extension fromVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
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
            fromNumOFRoom.text = URLs.numbersArray[row]
        }else if pickerView == floorPickerView{
            fromFloor.text = URLs.numbersArray[row]
        }else {
            typeeOfHouseTF.text = typeeOfHouseArray[row]
        }
    }
}


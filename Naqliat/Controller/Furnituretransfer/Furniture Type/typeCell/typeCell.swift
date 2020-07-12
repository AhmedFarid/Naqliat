//
//  typeCell.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class typeCell: UICollectionViewCell {

    @IBOutlet weak var numTextFaild: textFieldView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var checkBTN: UIButton!
    
    var isAdded = false
    var add: (()->())?
    let numOfRoomPickerView = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(type: furnitureTypeData){
        typeLabel.text = type.title
        numOfRoomPickerView.delegate = self
        numOfRoomPickerView.dataSource = self
        numTextFaild.inputView = numOfRoomPickerView
        self.numOfRoomPickerView.reloadAllComponents()
    }
    
    @IBAction func checkAcction(_ sender: Any) {
        add?()
    }
    
}



extension typeCell: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return URLs.numbersArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return URLs.numbersArray[row]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            numTextFaild.text = URLs.numbersArray[row]
    }
}

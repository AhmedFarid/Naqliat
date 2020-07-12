//
//  dateVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class dateVC: UIViewController {
    
    
    @IBOutlet weak var nowBtn: UIButton!
    @IBOutlet weak var dateAndTiime: textFieldView!
    
    var pramter = [parameters]()
    var x = [[String:Int]]()
    
    var fromAddressTF = ""
    var formTypeeOfHouseTF = ""
    var fromNumOFRoom = ""
    var fromFloor = ""
    var fromLiftAvaliabilty = ""
    var fromNotes = ""
    var fromLat = 0.0
    var fromLong = 0.0
    
    var toAddressTF = ""
    var toTypeeOfHouseTF = ""
    var toNumOFRoom = ""
    var toFloor = ""
    var toLiftAvaliabilty = ""
    var toNotes = ""
    var toLat = 0.0
    var toLong = 0.0
    
    private var datePiker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePiker()
        setUpNavColore(false, "Furniture transfer")
        setUpNav(menu: false, notification: true,back: false)
        
        // Do any additional setup after loading the view.
    }
    
    func createDatePiker(){
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .dateAndTime
        datePiker?.addTarget(self, action: #selector(dateVC.dateChanged(datePiker:)), for: .valueChanged)
        dateAndTiime.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateAndTiime.text = dateFormater.string(from: datePiker.date)
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        requestsApi.makeOrderApi(order_type: "furniture", from_number_of_rooms: fromNumOFRoom, from_floor: fromNumOFRoom, from_elevator: fromLiftAvaliabilty, from_type_of_house: formTypeeOfHouseTF, from_notes: fromNotes, from_other_notes: fromNotes, from_lat: "\(fromLat)", from_lng: "\(fromLong)", from_address: fromAddressTF, to_number_of_rooms: toNumOFRoom, to_floor: toFloor, to_elevator: toLiftAvaliabilty, to_type_of_house: toTypeeOfHouseTF, to_notes: toNotes, to_other_notes: toNotes, to_lat: "\(toLat)", to_lng: "\(toLong)", to_address: toAddressTF, date_work: dateAndTiime.text ?? "", car_type: "", parameterss: x, requestType: "create") { (error, success, message) in
            if success {
                let vc = suceessVC(nibName: "suceessVC", bundle: nil)
                self.navigationController!.pushViewController(vc, animated: false)
            }
        }
    }
    
    @IBAction func nowAction(_ sender: Any) {
    }
    
    
}

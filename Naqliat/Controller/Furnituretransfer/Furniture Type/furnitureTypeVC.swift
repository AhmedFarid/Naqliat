//
//  furnitureTypeVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class furnitureTypeVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var types = [furnitureTypeData]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, "Furniture transfer")
        setUpNav(menu: false, notification: true,back: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "typeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        handelTypeApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    func handelTypeApi() {
        loaderHelper()
        requestsApi.furnitureTypeApi{ (error,success,types) in
            if let types = types{
                self.types = types.data ?? []
                print(types)
                self.collectionView.reloadData()
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        let vc = dateVC(nibName: "dateVC", bundle: nil)
        vc.fromAddressTF = fromAddressTF
        vc.formTypeeOfHouseTF = formTypeeOfHouseTF
        vc.fromNumOFRoom = fromNumOFRoom
        vc.fromFloor = fromFloor
        vc.fromLiftAvaliabilty = fromLiftAvaliabilty
        vc.fromNotes = fromNotes
        vc.fromLat = fromLat
        vc.fromLong = fromLong
        
        vc.toAddressTF = toAddressTF
        vc.toTypeeOfHouseTF = toTypeeOfHouseTF
        vc.toNumOFRoom = toNumOFRoom
        vc.toFloor = toFloor
        vc.toLiftAvaliabilty = toLiftAvaliabilty
        vc.toNotes = toNotes
        vc.toLat = toLat
        vc.toLong = toLong
        
        vc.x = x
        
        self.navigationController!.pushViewController(vc, animated: false)
    }
}

extension furnitureTypeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? typeCell {
            cell.configureCell(type:  types[indexPath.row])
            cell.add = {
                if cell.isAdded == false {
                    guard let name = cell.numTextFaild.text, !name.isEmpty else {
                        let messages = NSLocalizedString("Enter Number Frist", comment: "hhhh")
                        let title = NSLocalizedString("Furniture Type ", comment: "hhhh")
                        self.showAlert(title: title, message: messages)
                        return
                    }
                    cell.isAdded = true
                    cell.checkBTN.setImage(UIImage(named: "Group 1468"), for: .normal)
                    let intValue = Int(cell.numTextFaild.text ?? "") ?? 0
                    self.x.append(["id": self.types[indexPath.row].id ?? 0,"value": intValue])
                    print(self.x)
                }else if cell.isAdded == true {
                    cell.isAdded = false
                    cell.numTextFaild.text = ""
                    cell.checkBTN.setImage(UIImage(named: "Group 14468"), for: .normal)
                    var currentIndex = 0
                    for id in self.x{
                        if id["id"] == self.types[indexPath.row].id {
                                self.x.remove(at: currentIndex)
                                break
                            }
                        currentIndex += 1
                    }
                    print(self.x)
                    
                }
            }
            return cell
        }else {
            return typeCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        
        
        
        return CGSize.init(width: screenWidth, height: 100)
    }
}

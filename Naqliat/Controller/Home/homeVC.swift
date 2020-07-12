//
//  homeVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class homeVC: UIViewController {

    @IBOutlet weak var tabelVIew: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, "Home")
        setUpNav(menu: true, notification: true)
        
        tabelVIew.delegate = self
        tabelVIew.dataSource = self
        self.tabelVIew.register(UINib.init(nibName: "homeCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

extension homeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? homeCell {
            if indexPath.row == 0 {
                cell.imageBtn.image = UIImage(named: "Group 1465")
                cell.nameCat.text = "Furniture transfer"
            }else if indexPath.row == 1 {
                cell.imageBtn.image = UIImage(named: "Group 1471")
                cell.nameCat.text = "Trailer"
            }else if indexPath.row == 2 {
                cell.imageBtn.image = UIImage(named: "Group 1470")
                cell.nameCat.text = "Light Trailer"
            }else if indexPath.row == 3 {
                cell.imageBtn.image = UIImage(named: "Group 1466")
                cell.nameCat.text = "Pickup"
            }else if indexPath.row == 4 {
                cell.imageBtn.image = UIImage(named: "Group 1467")
                cell.nameCat.text = "Flat Truck SATHA"
            }else {
                
            }
            return cell
        }else {
            return homeCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = fromVC(nibName: "fromVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = trailerVC(nibName: "trailerVC", bundle: nil)
            vc.type = "trailer"
            vc.name = "Trailer"
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
           let vc = trailerVC(nibName: "trailerVC", bundle: nil)
           vc.type = "light_trailer"
            vc.name = "Light Trailer"
           self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 3 {
            let vc = trailerVC(nibName: "trailerVC", bundle: nil)
            vc.type = "pickup"
            vc.name = "Pickup"
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.row == 4 {
            let vc = trailerVC(nibName: "trailerVC", bundle: nil)
            vc.type = "flat_truck"
            vc.name = "Flat Truck SATHA"
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
}

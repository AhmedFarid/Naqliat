//
//  suceessVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class suceessVC: UIViewController {

    var fromTrailer = 0
    
    @IBOutlet weak var imageSuccess: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Close"), style: .done, target: self, action: #selector(dissesView))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        if fromTrailer == 1 {
            imageSuccess.image = UIImage(named: "Group 1470-2")
        }
    }

    
    @objc func dissesView() {
        self.dismiss(animated: true, completion: nil)
            let vc = homeVC(nibName: "homeVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: false)
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

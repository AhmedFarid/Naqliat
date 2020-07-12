//
//  navSetupHelper.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

extension UIViewController {


    func setUpNavColore(_ isTranslucent: Bool,_ title: String){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1529411765, green: 0.2470588235, blue: 0.6039215686, alpha: 1)
        self.navigationItem.title = title
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    
    func setUpNav(menu: Bool = false, notification: Bool = false,back: Bool = false) {
           switch menu {
           case true:
               let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(sideMenu))
               self.navigationItem.leftBarButtonItem = leftBarButtonItem
           default:
               print("no")
           }
           switch notification {
           case true:
               let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "notifications"), style: .done, target: self, action: #selector(self.notification))
               self.navigationItem.rightBarButtonItem = rightBarButtonItem
//               cartApi.listOfCart{ (error,networkSuccess,codeSucess,liCart) in
//                   if liCart?.status == true {
//                       self.addBadge(count: liCart?.data?.list?.count ?? 0)
//                   }else {
//                           let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(self.showCart))
//                           self.navigationItem.rightBarButtonItem = rightBarButtonItem
//                   }
//               }
           default:
               print("no")
           }
        
        switch back {
        case true:
            let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 211"), style: .done, target: self, action: #selector(backAction))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
        default:
            print("no")
        }
       }
    
    
    @objc func backAction() {
        //navigationController?.popViewController(animated: false)
    }
    
       
       @objc func sideMenu() {
//           let menu = UIStoryboard(name: "sideMenu", bundle: nil).instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
//           menu.presentationStyle = .menuSlideIn
//           menu.menuWidth = view.frame.size.width - 50
//           present(menu, animated: true, completion: nil)
       }
       
       @objc func notification() {
//           let vc = cartVC(nibName: "cartVC", bundle: nil)
//           vc.fromMnue = false
//           self.navigationController!.pushViewController(vc, animated: true)
       }
    
}

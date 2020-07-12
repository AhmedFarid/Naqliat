//
//  loginVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class loginVC: UIViewController,NVActivityIndicatorViewable  {

    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true, "")
        
    }


    @IBAction func loginBtn(_ sender: Any) {
        let response = Validation.shared.validate(values:
            (ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.login(email: email.text ?? "", password: password.text ?? ""){ (error, success,Register,statusCode) in
                if success {
                    if statusCode == 200 {
                        self.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "Login", message: "email or password is incorrect")
                    }
                    
                }else {
                    self.showAlert(title: "Login", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "Login", message: message.localized())
        }
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        let vc = signupVC(nibName: "signupVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

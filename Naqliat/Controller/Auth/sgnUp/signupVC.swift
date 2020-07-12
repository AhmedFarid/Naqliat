//
//  signupVC.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class signupVC: UIViewController,NVActivityIndicatorViewable  {

    @IBOutlet weak var imageProfile: UIButton!
    @IBOutlet weak var fullName: textFieldView!
    @IBOutlet weak var phone: textFieldView!
    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            self.imageProfile.setImage(image, for: .normal)
        }
    }
    
    func openImagePiker(tag: Int) {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        //piker.sourceType = .camera
        piker.delegate = self
        piker.view.tag = tag
        
        let title = NSLocalizedString("Photo Source", comment: "profuct list lang")
        let message = NSLocalizedString("Chose A Source", comment: "profuct list lang")
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let titles = NSLocalizedString("Camera", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titles, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        let titless = NSLocalizedString("Photo Library", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titless, style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        let titlesss = NSLocalizedString("Cancel", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titlesss, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func profileImageAction(_ sender: Any) {
        openImagePiker(tag: 1)
    }
    
     @IBAction func signUpBTNAction(_ sender: Any) {
            let response = Validation.shared.validate(values:
                (ValidationType.alphabeticString, fullName.text ?? "")
                ,(ValidationType.phoneNo, phone.text ?? "")
                ,(ValidationType.email, email.text ?? "")
                ,(ValidationType.password, password.text ?? ""))
            switch response {
            case .success:
                loaderHelper()
                authApi.register(full_name: fullName.text ?? "", email: email.text ?? "", phone: phone.text ?? "", password: password.text ?? "", password_confirmation: password.text ?? "", image: picker_imag ?? #imageLiteral(resourceName: "Group 1464")){ (error, success, apiSuccess,Register,statusCode) in
                    if success {
                        if statusCode == 200 {
                                self.stopAnimating()
                                self.dismiss(animated: true, completion: nil)
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "SignUp", message: "email or phone are used")
                        }
                        
                    }else {
                        self.showAlert(title: "SignUp", message: "Check your network")
                        self.stopAnimating()
                    }
                    
                }
                break
            case .failure(_, let message):
                showAlert(title: "SignUp", message: message.localized())
            }
        }
    }


extension signupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if picker.view.tag == 1 {
                self.picker_imag = editedImage
            }
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            if picker.view.tag == 0 {
                self.picker_imag = originalImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

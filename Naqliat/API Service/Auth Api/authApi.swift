//
//  authApi.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class authApi: NSObject {
    
    class func login(email: String,password: String, completion: @escaping(_ error: Error?,_ success: Bool, _ userData: Auth?,_ statusCode: Int?)-> Void){
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let url = URLs.login
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    if response.response?.statusCode == 200 {
                        let register = try JSONDecoder().decode(Auth.self, from: response.data!)
                        helperAuth.saveAPIToken(token: register.accessToken ?? "")
                        completion(nil,true,register,response.response?.statusCode)
                    }else {
                        completion(nil,true,nil,response.response?.statusCode)
                    }
                    
                    
                }catch{
                    print("error")
                }
            }
        }
    }
    
    
    class func register(full_name: String, email: String,phone: String,password: String,password_confirmation: String,image: UIImage, completion: @escaping(_ error: Error?,_ success: Bool,_ authFiller: AuthFiler?, _ userData: Auth?,_ statusCode: Int?)-> Void){
        
        let parameters = [
            "full_name": full_name,
            "phone": phone,
            "email": email,
            "password": password,
            "password_confirmation": password_confirmation,
            "lat": "0.0",
            "lng": "0.0",
            "requestType": "create"
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        let url = URLs.signup
        
        print(url)
        print(parameters)
         AF.upload(multipartFormData: { multiPart in
                   for p in parameters {
                       multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
                   }
                   multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
               }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                   print("Upload Progress: \(progress.fractionCompleted)")
               }).responseJSON(completionHandler: { data in
                   print("upload finished: \(data)")
               }).response { (response) in
                   switch response.result
                   {
                   case .failure(let error):
                       completion(error, false,nil,nil,nil)
                       print(error)
                   case .success:
                do{
                    print(response)
                    if response.response?.statusCode == 200 {
                        let register = try JSONDecoder().decode(Auth.self, from: response.data!)
                        helperAuth.saveAPIToken(token: register.accessToken ?? "")
                        completion(nil,true,nil,register,response.response?.statusCode)
                    }else {
                        let registerFiler = try JSONDecoder().decode(AuthFiler.self, from: response.data!)
                        if registerFiler.success == false {
                            completion(nil,true,registerFiler,nil,response.response?.statusCode)
                        }
                    }
                    
                    
                }catch{
                    print("error")
                }
            }
        }
    }
}

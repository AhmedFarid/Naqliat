//
//  myOrdersApi.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class myOrdersApi: NSObject {
    
    
    class func newOrderApi(completion: @escaping(_ error: Error?,_ success: Bool,_ furnitureTypes: furnitureType?)-> Void){
        
        let url = URLs.newOrders
        print(url)
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
        ]
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let furnitureTypes = try JSONDecoder().decode(furnitureType.self, from: response.data!)
                    if furnitureTypes.success == true {
                        completion(nil,true,furnitureTypes)
                    }else {
                        completion(nil,true,furnitureTypes)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
}

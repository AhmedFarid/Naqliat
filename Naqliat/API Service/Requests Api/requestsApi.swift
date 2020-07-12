//
//  requestsApi.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class requestsApi: NSObject {
    
    
    class func furnitureTypeApi(completion: @escaping(_ error: Error?,_ success: Bool,_ furnitureTypes: furnitureType?)-> Void){
        
        
        let url = URLs.parameters
        print(url)
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
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
    
    class func makeOrderApi(order_type:String,from_number_of_rooms: String,from_floor: String,from_elevator: String,from_type_of_house: String,from_notes: String,from_other_notes: String,from_lat: String,from_lng: String,from_address: String,to_number_of_rooms: String,to_floor: String,to_elevator: String,to_type_of_house: String,to_notes: String,to_other_notes: String,to_lat: String,to_lng: String,to_address: String,date_work: String,car_type: String,parameterss: [[String:Int]],requestType: String, completion: @escaping(_ error: Error?,_ success: Bool,_ fav: Messages?)-> Void){
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.makeOrder
        
       
       

        
        let parametars = [
            "order_type":order_type,
            "from_number_of_rooms": from_number_of_rooms,
            "from_floor": from_floor,
            "from_elevator": from_elevator,
            "from_type_of_house": from_type_of_house,
            "from_notes": from_notes,
            "from_other_notes": from_other_notes,
            "from_lat": from_lat,
            "from_lng": from_lng,
            "from_address": from_address,
            "to_number_of_rooms": to_number_of_rooms,
            "to_floor": to_floor,
            "to_elevator": to_elevator,
            "to_type_of_house": to_type_of_house,
            "to_notes": to_notes,
            "to_other_notes": to_other_notes,
            "to_lat": to_lat,
            "to_lng": to_lng,
            "to_address": to_address,
            "date_work": date_work,
            "car_type": car_type,
            "requestType": requestType,
            "parameters": parameterss
            ] as [String : Any]
        print(JSONSerializer.toJson(parameterss))
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
        ]
        
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: JSONEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let addFov = try JSONDecoder().decode(Messages.self, from: response.data!)
                    if addFov.success == true {
                        completion(nil,true,addFov)
                    }else {
                        completion(nil,true,addFov)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}

//["car_type": "", "from_notes": "cc", "from_number_of_rooms": "3", "from_address": "aa", "date_work": "2020-07-30 10:30:30", "to_type_of_house": "flat", "from_lat": "0.0", "to_other_notes": "ee", "to_number_of_rooms": "44", "to_elevator": "1", "from_lng": "0.0", "to_address": "ff", "parameters": [["id": 1, "value": 11], ["id": 2, "value": 13]], "to_floor": "44", "to_lat": "0.0", "requestType": "create", "from_elevator": "1", "order_type": "furniture", "to_notes": "ee", "to_lng": "0.0", "from_other_notes": "cc", "from_floor": "3", "from_type_of_house": "flat"]
//success({
//    data = "";
//    message = "Added successfully";
//    success = 1;
//})


//"from_lat": "0.0", "parameters": [[id: 1, value: "", id: 2, value: "22"]], "to_lng": "0.0", "car_type": "", "to_notes": "tt", "from_number_of_rooms": "gg", "to_other_notes": "tt", "to_lat": "0.0", "from_address": "ty", "to_elevator": "1", "order_type": "furniture", "from_type_of_house": "ggg", "from_elevator": "1", "from_notes": "tt", "to_address": "tt", "to_type_of_house": "gg", "to_number_of_rooms": "gg", "from_floor": "gg", "from_other_notes": "tt", "to_floor": "gg", "date_work": "vvvv", "requestType": "create", "from_lng": "0.0"]


//["to_lng": "0.0", "from_address": "", "date_work": "", "car_type": "", "to_lat": "0.0", "from_type_of_house": "", "parameters": ["[{\"id\": 1, \"value\": \"\"}, {\"id\": 2, \"value\": \"\"}]"], "from_lat": "0.0", "from_elevator": "0", "requestType": "create", "to_number_of_rooms": "", "to_elevator": "0", "to_notes": "", "from_lng": "0.0", "to_address": "", "from_number_of_rooms": "", "order_type": "furniture", "to_type_of_house": "", "from_notes": "", "from_other_notes": "", "from_floor": "", "to_other_notes": "", "to_floor": ""]



//"from_number_of_rooms": "43", "to_address": "dddd", "from_floor": "43", "from_lng": "0.0", "from_notes": "r", "order_type": "furniture", "from_address": "aaaa", "to_notes": "cc", "car_type": "", "parameters": [[Naqliat.parameters(id: 1, value: "55"), Naqliat.parameters(id: 2, value: "22")]], "from_type_of_house": "flat", "date_work": "2020-07-30 10:20:30", "from_elevator": "1", "to_lng": "0.0", "requestType": "create", "to_number_of_rooms": "4", "to_elevator": "1", "from_other_notes": "r", "to_type_of_house": "flat", "to_other_notes": "cc", "from_lat": "0.0", "to_floor": "44", "to_lat": "0.0"]

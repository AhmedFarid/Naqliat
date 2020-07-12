//
//  furnitureType.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct furnitureType: Codable {
    let success: Bool?
    let data: [furnitureTypeData]?
    let message: String?
}

struct furnitureTypeData: Codable {
    let id: Int?
    let title: String?
}

//public struct data:Codable{
//    let dataType: [parameters]
//}
//
//public struct parameters:Codable {
//    let id: Int
//    let value: String
//}

struct parameters: Codable {
    let id: Int, value: String?
}

typealias parametersss = [parameters]


//class parameters {
//    let id:Int?, value: String?
//
//    init(id: Int?, value: String?) {
//        self.id = id
//        self.value = value
//    }
//}
//
//
//class parameters: Codable {
//    let id:Int?, value: String?
//
//    init(id: Int?, value: String?) {
//        self.id = id
//        self.value = value
//    }
//}
//
//typealias parametersss = [parameters]

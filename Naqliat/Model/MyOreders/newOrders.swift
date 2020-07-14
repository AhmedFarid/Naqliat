//
//  newOrders.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import Foundation

struct NewOrders: Codable {
    let success: Bool?
    let data: [Datum]?
    let message: String?
}

struct Datum: Codable {
    let id: Int?
    let total, status, orderType, fromNumberOfRooms: String?
    let fromFloor, fromElevator, fromTypeOfHouse, fromNotes: String?
    let fromOtherNotes, fromLat, fromLng, fromAddress: String?
    let toNumberOfRooms, toFloor, toElevator, toTypeOfHouse: String?
    let toNotes, toOtherNotes, toLat, toLng: String?
    let toAddress, carType, dateWork, driver: String?
    let offers: [Offer]?

    enum CodingKeys: String, CodingKey {
        case id, total, status
        case orderType = "order_type"
        case fromNumberOfRooms = "from_number_of_rooms"
        case fromFloor = "from_floor"
        case fromElevator = "from_elevator"
        case fromTypeOfHouse = "from_type_of_house"
        case fromNotes = "from_notes"
        case fromOtherNotes = "from_other_notes"
        case fromLat = "from_lat"
        case fromLng = "from_lng"
        case fromAddress = "from_address"
        case toNumberOfRooms = "to_number_of_rooms"
        case toFloor = "to_floor"
        case toElevator = "to_elevator"
        case toTypeOfHouse = "to_type_of_house"
        case toNotes = "to_notes"
        case toOtherNotes = "to_other_notes"
        case toLat = "to_lat"
        case toLng = "to_lng"
        case toAddress = "to_address"
        case carType = "car_type"
        case dateWork = "date_work"
        case driver, offers
    }
}

struct Offer: Codable {
    let id: Int?
    let price, notes, expectedDateTime: String?
    let driver: Driver?
    let customer: Customer?

    enum CodingKeys: String, CodingKey {
        case id, price, notes
        case expectedDateTime = "expected_date_time"
        case driver, customer
    }
}


struct Customer: Codable {
    let id: Int?
    let fullName, email, phone: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email, phone, image
    }
}

struct Driver: Codable {
    let id: Int?
    let fullName, email, phone: String?
    let image: String?
    let nationalID, licenceID, licenceCarID, carBoardNumber: String?
    let carType, carModel, carYear, workType: String?
    let workStatus: String?
    let driverImage: String?
    let carImage: String?
    let nationalIDImage, licenceImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email, phone, image
        case nationalID = "national_id"
        case licenceID = "licence_id"
        case licenceCarID = "licence_car_id"
        case carBoardNumber = "car_board_number"
        case carType = "car_type"
        case carModel = "car_model"
        case carYear = "car_year"
        case workType = "work_type"
        case workStatus = "work_status"
        case driverImage = "driver_image"
        case carImage = "car_image"
        case nationalIDImage = "national_id_image"
        case licenceImage = "licence_image"
    }
}

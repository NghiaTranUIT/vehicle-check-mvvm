//
//  VehicleCheckModels.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation

struct VehicleCheck: Codable {

    let sections: [Section]
}

struct Section: Codable {

    enum Kind: String, Codable {
        case general
        case outside
        case incab
    }

    let id: String
    let kind: Kind
    let name: String
    let subSections: [SubSection]
}


struct SubSection: Codable {

    enum Kind: String, Codable {
        case vehicle
        case trailer
        case general
    }

    let kind: Kind
    let id: String
    let name: String
    let attributes: [Attribute]
}

struct Attribute: Codable {

    enum Status: String, Codable {
        case yes
        case no
        case notSelect
    }

    let id: String
    let name: String
    let status: Status
    let key: String

    init(id: String, name: String, status: Status = Status.notSelect, key: String) {
        self.id = id
        self.name = name
        self.status = status
        self.key = key
    }
}

//
//  VehicleCheckModels.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation

class VehicleCheck: Codable {

    let sections: [Section]

    public init(sections: [Section]) {
        self.sections = sections
    }
}

class Section: Codable {

    enum Kind: String, Codable {
        case general
        case outside
        case incab
    }

    let id: String
    let kind: Kind
    let name: String
    let subSections: [SubSection]

    public init(id: String, kind: Kind, name: String, subSections: [SubSection]) {
        self.id = id
        self.kind = kind
        self.name = name
        self.subSections = subSections
    }
}


class SubSection: Codable {

    enum Kind: String, Codable {
        case vehicle
        case trailer
        case general
    }

    let kind: Kind
    let id: String
    let name: String
    let attributes: [Attribute]

    init(kind: Kind, id: String, name: String, attributes: [Attribute]) {
        self.kind = kind
        self.id = id
        self.name = name
        self.attributes = attributes
    }
}

class Attribute: Codable {

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

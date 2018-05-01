//
//  VehicleCheckData.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation

struct VehicleCheckFactory {

    static func generateVehicleCheckResponse() -> VehicleCheck {

        var section_general: Section!

        // General
        if true {
            let attribute_1 = Attribute(id: "1", name: "Have you put your Tacho on other work?", key: "tacho")
            let attribute_2 = Attribute(id: "2", name: "Vehicle registration: Vehicle Registration (Type)?", key: "vehicle_registration")
            let attribute_3 = Attribute(id: "3", name: "Trailer registration: Trailer Registration (Type)", key: "trailer_registration")

            let general = SubSection(kind: SubSection.Kind.general, id: "1", name: "General", attributes: [attribute_1, attribute_2, attribute_3])

            // Final
            section_general = Section(id: "1", kind: Section.Kind.general, name: "General", subSections: [general])
        }

        // Out side
        // Has both Vehicle and Trailer as sub-section
        var section_Outside: Section!
        if true {
            let attribute_vehicle_1 = Attribute(id: "1", name: "Lights and indicators", key: "lights_indicators")
            let attribute_vehicle_2 = Attribute(id: "2", name: "Fuel/Oil Leaks", key: "fuel_oil")

            let attribute_trailer_1 = Attribute(id: "3", name: "Reflectors)", key: "reflectors")
            let attribute_trailer_2 = Attribute(id: "4", name: "Doors and exits)", key: "doors_exits")

            let vehicle = SubSection(kind: SubSection.Kind.vehicle, id: "1", name: "Vehicle", attributes: [attribute_vehicle_1, attribute_vehicle_2])
            let trailer = SubSection(kind: SubSection.Kind.trailer, id: "2", name: "Trailer", attributes: [attribute_trailer_1, attribute_trailer_2])

            // Final
            section_Outside = Section(id: "2", kind: Section.Kind.outside, name: "Outside", subSections: [vehicle, trailer])
        }

        // Inside
        // Has both Vehicle and Trailer as sub-section
        var section_inside: Section!
        if true {
            let attribute_vehicle_1 = Attribute(id: "1", name: "Mirrors and glass", key: "mirrors_glass")
            let attribute_vehicle_2 = Attribute(id: "2", name: "Brakes", key: "brakes")

            let attribute_trailer_1 = Attribute(id: "3", name: "Seat and Seatbelt)", key: "seat_seatbelt")
            let attribute_trailer_2 = Attribute(id: "4", name: "Warning Lamp)", key: "doors_exits")

            let vehicle = SubSection(kind: SubSection.Kind.vehicle, id: "1", name: "Vehicle", attributes: [attribute_vehicle_1, attribute_vehicle_2])
            let trailer = SubSection(kind: SubSection.Kind.trailer, id: "2", name: "Trailer", attributes: [attribute_trailer_1, attribute_trailer_2])

            // Final
            section_inside = Section(id: "2", kind: Section.Kind.incab, name: "Inside", subSections: [vehicle, trailer])
        }

        // Response
        let vehicleCheck = VehicleCheck(sections: [section_general, section_Outside, section_inside])
        return vehicleCheck
    }
}



//
//  Property.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/10/23.
//

import Foundation
import SwiftData

@Model
public final class Property {
    @Attribute(.unique) public var id: String
    var name: String

    @Relationship(deleteRule: .nullify, inverse: \City.properties)
    var city: City?

    var latitude: String
    var longitude: String

    init(id: String, name: String, city: CityDTO, latitude: String, longitude: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    init(from propertyDTO: PropertyDTO) {
        self.id = propertyDTO.id
        self.name = propertyDTO.name
        self.latitude = propertyDTO.latitude
        self.longitude = propertyDTO.longitude
    }
}

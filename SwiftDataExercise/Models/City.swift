//
//  City.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/10/23.
//

import SwiftData

@Model
public final class City {
    @Attribute(.unique)
    public var id: String

    var name: String
    var country: String
    var idCountry: String

    @Relationship
    var properties: [Property]

    init(id: String = "", name: String = "", country: String = "", idCountry: String = "") {
        self.id = id
        self.name = name
        self.country = country
        self.idCountry = idCountry
        properties = []
    }

    init(from cityDTO: CityDTO) {
        id = cityDTO.id
        name = cityDTO.name
        country = cityDTO.country
        idCountry = cityDTO.idCountry
        properties = []
    }
}

//
//  PropertyDTO.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/8/23.
//

import Foundation
import SwiftData

struct PropertyDTO: Codable {
    var id: String
    var name: String
    var city: CityDTO
    var latitude: String
    var longitude: String
}

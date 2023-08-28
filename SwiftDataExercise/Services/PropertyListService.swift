//
//  PropertyListService.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/10/23.
//

import Foundation
import SwiftData

class PropertyListService {

    private var remoteRepository: PropertyAccesing
    private var localRepostitory: PropertyLocalAccessing

    init(remoteRepository: PropertyAccesing = PropertyListRemoteRepository(), localRepository: PropertyLocalAccessing) {
        self.remoteRepository = remoteRepository
        self.localRepostitory = localRepository
    }

    func fetchPropertyList(in cityId: Int) async throws -> [Property] {

        var localPropertyList = try await localRepostitory.fetchPropertyList()

        if localPropertyList.isEmpty {
            let propertyList = await fetchRemoteProperties(in: cityId)
            try localRepostitory.savePropertyList(propertyList)

            return propertyList
        } else {
            return localPropertyList
        }
    }

    private func fetchRemoteProperties(in cityId: Int) async -> [Property] {
        do {
            let propertyListDTO = try await remoteRepository.getPropertyList(in: cityId)

            let propertyList: [Property] = propertyListDTO.properties.map { Property(from: $0) }

            return propertyList
        } catch {
            fatalError()
        }
    }
}

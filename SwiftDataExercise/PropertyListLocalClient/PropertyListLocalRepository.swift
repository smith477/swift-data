//
//  PropertyListLocalRepository.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/10/23.
//

import Foundation
import SwiftData

protocol PropertyLocalAccessing {
    func savePropertyList(_ propertyList: [Property]) throws
    func fetchPropertyList() async throws -> [Property]
}

class PropertyListLocalRepository: PropertyLocalAccessing {
    var context: ModelContext

    init(container: ModelContainer) {
        context = ModelContext(container)
    }

    func savePropertyList(_ propertyList: [Property]) throws {
        SWLogger.log.info("Saving properties locally")
        for property in propertyList {
            DispatchQueue.main.async {
                SWLogger.log.debug("\(property.id) - \(property.name)")
                self.context.insert(property)
            }
        }

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }

    func fetchPropertyList() async throws -> [Property] {
        do {
            let propertyListDescriptor = FetchDescriptor<Property>()
            let result = try context.fetch(propertyListDescriptor)

            return result
        } catch {
            throw NSError()
        }
    }
}

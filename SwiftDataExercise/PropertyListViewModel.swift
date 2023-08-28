//
//  PropertyListViewModel.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/10/23.
//

import SwiftUI

@Observable
class PropertyListViewModel {
    private var propertyService: PropertyListService
    var propertyList: [Property] = []

    var state: State = .idle

    enum State {
        case idle
        case loading
        case loaded
    }

    init(propertyService: PropertyListService) {
        self.propertyService = propertyService
    }

    func fetchProperties() {
        state = .loading
        performFetchProperties()
    }

    private func performFetchProperties() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await self.propertyService.fetchPropertyList(in: 1530)
                self.state = .loaded
                self.propertyList = result
            } catch let error {
               print(error)
            }
        }
    }
}

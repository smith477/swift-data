//
//  ContentView.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/8/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let viewModel: PropertyListViewModel
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Property.self, City.self)
            let propertyService = PropertyListService(localRepository: PropertyListLocalRepository(container: container))
            viewModel = PropertyListViewModel(propertyService: propertyService)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    var body: some View {
        rootView
            .modelContainer(container)
    }

    @ViewBuilder
    var rootView: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.fetchProperties)
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        case .loaded:
            propertyListView
        }
    }

    @ViewBuilder
    var propertyListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.propertyList, id: \.id) { property in
                    VStack {
                        Text(property.name)
                        if let cityName = property.city?.name {
                            Text(cityName)
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

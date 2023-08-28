//
//  TestView.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/15/23.
//

import SwiftUI
import SwiftData

@Model
class Category {

    @Attribute(.unique)
    var title: String

    var items: [Item]?

    init(title: String) {
        self.title = title
    }
}

@Model
final class Item {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool

    @Relationship(deleteRule: .nullify, inverse: \Category.items)
    var category: Category?

    init(
        title: String = "",
        timestamp: Date = . now,
        isCritical: Bool = false,
        isCompleted: Bool = false
    ) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
//
//
//struct TestView: View {
//
//    @Environment(\.modelContext) private var modelContext
//
//    var body: some View {
//        
//    }
//}
//
//#Preview {
//    TestView()
//}

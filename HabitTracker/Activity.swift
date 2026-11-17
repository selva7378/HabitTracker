//
//  Activity.swift
//  HabitTracker
//

import Foundation

struct Activity: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int
    
    init(id: UUID = UUID(), title: String, description: String, completionCount: Int = 0) {
        self.id = id
        self.title = title
        self.description = description
        self.completionCount = completionCount
    }
}

#if DEBUG
extension Activity {
    static let example = Activity(
        title: "Daily Reading",
        description: "Read at least 20 pages of a book to expand knowledge and focus.",
        completionCount: 14
    )
}
#endif

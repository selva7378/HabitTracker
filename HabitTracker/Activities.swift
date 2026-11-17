//
//  Activities.swift
//  HabitTracker
//

import Foundation
import Observation

@Observable
class Activities {
    private let saveKey = "HabitTracker.Activities"
    
    var items = [Activity]() {
        didSet {
            save()
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedData) {
                items = decodedItems
                return
            }
        }
        
        // Initialize default sample items on first launch
        items = [
            Activity(
                title: "Daily Reading",
                description: "Read at least 20 pages of a book every day.",
                completionCount: 14
            ),
            Activity(
                title: "Morning Workout",
                description: "Complete 30 minutes of cardio, strength training, or yoga.",
                completionCount: 8
            ),
            Activity(
                title: "Mindful Meditation",
                description: "Practice 10 minutes of guided mindfulness and deep breathing.",
                completionCount: 5
            ),
            Activity(
                title: "Hydration Goal",
                description: "Drink at least 2.5 liters of clean water throughout the day.",
                completionCount: 21
            )
        ]
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}

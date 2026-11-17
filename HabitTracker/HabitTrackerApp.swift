//
//  HabitTrackerApp.swift
//  HabitTracker
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    @State private var activities = Activities()
    
    var body: some Scene {
        WindowGroup {
            ContentView(activities: activities)
        }
    }
}

//
//  ContentView.swift
//  HabitTracker
//

import SwiftUI

struct ContentView: View {
    var activities: Activities
    @State private var showingAddActivity = false
    @State private var path = NavigationPath()
    
    init(activities: Activities = Activities()) {
        self.activities = activities
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if activities.items.isEmpty {
                    ContentUnavailableView(
                        "No Habits Tracked",
                        systemImage: "checklist",
                        description: Text("Start building good habits today by tapping the + button.")
                    )
                } else {
                    List {
                        ForEach(activities.items) { activity in
                            NavigationLink(value: activity) {
                                HabitRowView(activity: activity)
                            }
                        }
                        .onDelete(perform: removeActivities)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("HabitTracker")
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity, activities: activities)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !activities.items.isEmpty {
                        EditButton()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddActivity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Habit")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
            .onAppear {
                if ProcessInfo.processInfo.arguments.contains("-showDetail"), let first = activities.items.first {
                    path.append(first)
                }
                if ProcessInfo.processInfo.arguments.contains("-showAdd") {
                    showingAddActivity = true
                }
            }
        }
    }
    
    private func removeActivities(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct HabitRowView: View {
    let activity: Activity
    
    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if !activity.description.isEmpty {
                    Text(activity.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.caption2)
                Text("\(activity.completionCount)")
                    .font(.subheadline.bold())
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(activity.completionCount > 0 ? Color.blue.opacity(0.12) : Color.gray.opacity(0.12))
            .foregroundColor(activity.completionCount > 0 ? .blue : .secondary)
            .clipShape(Capsule())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView(activities: Activities())
}

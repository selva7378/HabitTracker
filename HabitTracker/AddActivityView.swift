//
//  AddActivityView.swift
//  HabitTracker
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) private var dismiss
    
    var activities: Activities
    
    @State private var title = ProcessInfo.processInfo.arguments.contains("-sampleAdd") ? "Learn SwiftUI & iOS" : ""
    @State private var description = ProcessInfo.processInfo.arguments.contains("-sampleAdd") ? "Build real-world Swift applications, master modern architectures, and test features daily." : ""
    @State private var startingCount = ProcessInfo.processInfo.arguments.contains("-sampleAdd") ? 3 : 0
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Details") {
                    TextField("Habit Title (e.g. Read Books)", text: $title)
                    
                    TextField("Description (optional)", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Initial Progress") {
                    Stepper("Starting Completions: \(startingCount)", value: $startingCount, in: 0...9999)
                }
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveActivity()
                    }
                    .disabled(!isFormValid)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private func saveActivity() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        let newActivity = Activity(
            title: trimmedTitle,
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            completionCount: startingCount
        )
        activities.items.append(newActivity)
        dismiss()
    }
}

#Preview {
    AddActivityView(activities: Activities())
}

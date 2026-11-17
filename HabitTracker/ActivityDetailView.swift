//
//  ActivityDetailView.swift
//  HabitTracker
//

import SwiftUI

struct ActivityDetailView: View {
    var activity: Activity
    var activities: Activities
    
    // Look up the latest version of the activity from the activities store
    private var currentActivity: Activity {
        activities.items.first(where: { $0.id == activity.id }) ?? activity
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Stat Header Card
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color.blue.opacity(0.8), Color.indigo],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        Image(systemName: "flame.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 8)
                    
                    Text("\(currentActivity.completionCount)")
                        .font(.system(size: 54, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .contentTransition(.numericText())
                    
                    Text("Total Completions")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(UIColor.secondarySystemGroupedBackground))
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                )
                
                // Action Buttons
                VStack(spacing: 14) {
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            incrementCount()
                        }
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                            Text("Complete Today (+1)")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.indigo],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0, y: 3)
                    }
                    
                    // Stepper for custom count adjustment
                    HStack {
                        Text("Adjust Count")
                            .font(.body)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Stepper("", value: Binding(
                            get: { currentActivity.completionCount },
                            set: { newValue in
                                updateCount(to: newValue)
                            }
                        ), in: 0...99999)
                        .labelsHidden()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(UIColor.secondarySystemGroupedBackground))
                    )
                }
                
                // Description Section
                VStack(alignment: .leading, spacing: 10) {
                    Label("Description", systemImage: "text.alignleft")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(currentActivity.description.isEmpty ? "No description provided." : currentActivity.description)
                        .font(.body)
                        .foregroundColor(currentActivity.description.isEmpty ? .secondary : .primary)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(UIColor.secondarySystemGroupedBackground))
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                )
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(currentActivity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func incrementCount() {
        if let index = activities.items.firstIndex(where: { $0.id == activity.id }) {
            var updated = activities.items[index]
            updated.completionCount += 1
            activities.items[index] = updated
        }
    }
    
    private func updateCount(to newCount: Int) {
        guard newCount >= 0 else { return }
        if let index = activities.items.firstIndex(where: { $0.id == activity.id }) {
            var updated = activities.items[index]
            updated.completionCount = newCount
            activities.items[index] = updated
        }
    }
}

#Preview {
    NavigationStack {
        ActivityDetailView(activity: .example, activities: Activities())
    }
}

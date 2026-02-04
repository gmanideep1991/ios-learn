//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Manideep Gattamaneni on 2/4/26.
//

import SwiftUI

struct ActivityDetailView: View {
    var activities: Activities
    var selectedActivity: ActivityItem
    var body: some View {
        VStack{
            Text(selectedActivity.name)
            Text(selectedActivity.description)
            Text(
                "Number of times completed: \(selectedActivity.completedCount)"
            )
            Button{
                if let selectedItem = activities.items.firstIndex(
                    of: selectedActivity
                ){
                    activities.items[selectedItem].completedCount += 1
                    activities.save()
                }
                    
            }label:{
                Label("Activity Completed", systemImage: "checkmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .green)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                        Capsule().fill(Color.green.opacity(0.2))
                    )
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ActivityDetailView(activities: Activities(), selectedActivity: ActivityItem(name: "hello",  description: "hi"))
}

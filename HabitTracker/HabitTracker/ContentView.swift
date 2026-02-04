//
//  ContentView.swift
//  HabitTracker
//
//  Created by Manideep Gattamaneni on 2/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var activities:Activities = Activities()
    @State private var showDetails:Bool = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(activities.items){ activity in
                    
                    NavigationLink{
                        ActivityDetailView(activities: activities, selectedActivity: activity)
                    } label: {
                        HStack{
                            Text(activity.name)
                            Spacer()
                            Text("\(activity.completedCount)")
                        }
                        
                    }
                }.onDelete(perform: removeActivity)
            }
            NavigationLink(
                "Add Activity",
                destination: AddActivityItemView(activities: activities)
            )
            .navigationTitle("Activities")
            .toolbar {
                NavigationLink(
                    
                    destination: AddActivityItemView(activities: activities)
                ){
                    Image(systemName: "plus")
                }
                EditButton()
            }
        }
    }
    func removeActivity(at offsets: IndexSet){
        if let index = offsets.first{
            let item = activities.items[index]
            activities.items.removeAll{$0.id == item.id}
        }
    }
}

#Preview {
    ContentView()
}

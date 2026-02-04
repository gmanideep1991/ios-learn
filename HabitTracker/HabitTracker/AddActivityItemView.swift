//
//  AddActivityItemView.swift
//  HabitTracker
//
//  Created by Manideep Gattamaneni on 2/3/26.
//

import SwiftUI

struct AddActivityItemView: View {
    var activities: Activities
    @State var name: String = ""
    @State var description: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Activity")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel", role: .cancel){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save", role: .confirm){
                        activities.items.append(
                            ActivityItem(name: name, description: description)
                        )
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddActivityItemView(activities: Activities())
}

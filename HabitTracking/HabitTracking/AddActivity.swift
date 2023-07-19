//
//  AddActivity.swift
//  HabitTracking
//
//  Created by Daniel Camarena on 7/19/23.
//

import SwiftUI

struct AddActivity: View {
    @ObservedObject var Activities: Activities
    @State private var name = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add a new activity")
            .toolbar{
                Button("Save"){
                    let activity = Activity(name:name, description: description)
                    Activities.items.append(activity)
                    dismiss()
                }
                .disabled(name.isEmpty || description.isEmpty)
            }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var activities = Activities()
    static var previews: some View {
        AddActivity(Activities: activities)
    }
}

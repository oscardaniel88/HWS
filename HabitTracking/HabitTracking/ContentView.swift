//
//  ContentView.swift
//  HabitTracking
//
//  Created by Daniel Camarena on 7/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var activities = Activities()
    @State private var showingAddActivity = false
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items){
                    item in
                        NavigationLink {
                            ActivityDetail(activity: item, activities: activities)
                        }label: {
                            HStack{
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text("\(item.timesCompleted)")
                                    .font(.subheadline)
                        }
                        
                    }
                }.onDelete(perform: removeActivity(at:))
            }
            .navigationTitle("Activity Tracker")
            .toolbar{
                Button{
                    showingAddActivity = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $showingAddActivity){
            AddActivity(Activities: activities)
        }
    }
    func removeActivity(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

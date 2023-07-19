//
//  ActivityDetail.swift
//  HabitTracking
//
//  Created by Daniel Camarena on 7/19/23.
//

import SwiftUI

struct ActivityDetail: View {
    let activity: Activity
    var activities: Activities
    var body: some View {
        VStack{
            Form {
                Text(activity.name)
                    .font(.headline)
                Text(activity.description)
                    .font(.subheadline)
                HStack{
                    Text("Completed")
                    Spacer()
                    Text("\(activity.timesCompleted) times")
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            var newActivity = activity
                            newActivity.timesCompleted += 1
                            let index = activities.items.firstIndex(of: activity) ?? 0
                            activities.items[index] = newActivity
                        }
                }
            }
        }
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var activity = Activity(name:"Test", description: "Description")
    static var activities = Activities()
    static var previews: some View {
        ActivityDetail(activity: activity, activities: activities)
    }
}

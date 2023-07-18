//
//  MissionListView.swift
//  Moonshot
//
//  Created by Daniel Camarena on 7/17/23.
//

import SwiftUI

struct MissionListView: View {
    let missions : [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        ForEach(missions){
            mission in
            NavigationLink {
                MissionView(mission:mission, astronauts: astronauts)
            }label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:100, height: 100)
                        .padding()
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                        }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                
                )
            }
        }
    }
}

struct MissionListView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] =  Bundle.main.decode("astronauts.json")
    static let missions : [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionListView(missions: missions, astronauts: astronauts)
    }
}

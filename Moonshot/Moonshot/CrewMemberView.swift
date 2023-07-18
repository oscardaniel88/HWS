//
//  CrewMember.swift
//  Moonshot
//
//  Created by Daniel Camarena on 7/17/23.
//

import SwiftUI

struct CrewMemberView: View {
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) {
                    crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(.white, lineWidth: 1.0)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                }
            }
            
        }
    }
}

struct CrewMember_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var crewMembers = [CrewMember(role:"Test", astronaut: astronauts["aldrin"]!)]
    static var previews: some View {
        CrewMemberView(crew:crewMembers)
            .preferredColorScheme(.dark)
    }
}

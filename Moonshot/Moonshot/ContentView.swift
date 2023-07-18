//
//  ContentView.swift
//  Moonshot
//
//  Created by Daniel Camarena on 7/15/23.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let emptyColumns = [GridItem]()
    let astronauts: [String: Astronaut] =  Bundle.main.decode("astronauts.json")
    @State var showAsGrid = false
    let missions : [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        NavigationView {
            Group {
                if showAsGrid {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            MissionListView(missions: missions, astronauts: astronauts)
                        }.padding(.bottom, 5)
                    }
                } else {
                    List {
                        MissionListView(missions: missions, astronauts: astronauts)
                            .padding(.bottom, 5)
                            .listRowBackground(Color.darkBackground)
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark )
            .toolbar{
                Button( showAsGrid ? "List" : "Grid"){
                    showAsGrid.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

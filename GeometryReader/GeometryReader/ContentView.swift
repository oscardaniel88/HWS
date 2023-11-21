//
//  ContentView.swift
//  GeometryReader
//
//  Created by Daniel Camarena on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

        var body: some View {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(colors[index % 7])
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                .opacity(geo.frame(in: .global).maxY * 0.001)
                        }
                        .frame(height: 40)
                    }
                }
            }
        }
}

#Preview {
    ContentView()
}

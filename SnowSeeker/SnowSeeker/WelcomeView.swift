//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Daniel Camarena on 11/22/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}

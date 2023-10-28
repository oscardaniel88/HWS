//
//  Background.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/28/23.
//

import SwiftUI

struct Background: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) {
                newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
                            
            }
    }
}

#Preview {
    Background()
}

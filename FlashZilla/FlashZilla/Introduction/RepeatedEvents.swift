//
//  RepeatedEvents.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/28/23.
//

import SwiftUI

struct RepeatedEvents: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5 ,on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer){
                time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                }else {
                    print("The time is now \(time)")
                }
                counter += 1
            }
    }
}

#Preview {
    RepeatedEvents()
}

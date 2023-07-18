//
//  DividerView.swift
//  Moonshot
//
//  Created by Daniel Camarena on 7/17/23.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height:2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
            .preferredColorScheme(.dark)
    }
}

//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Daniel Camarena on 7/21/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.orderData.address.name)
                TextField("Address", text: $order.orderData.address.address)
                TextField("City", text: $order.orderData.address.city)
                TextField("Zip", text: $order.orderData.address.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                }label: {
                    Text("Checkout")
                }
            }
            .disabled(order.orderData.address.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

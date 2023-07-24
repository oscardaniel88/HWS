//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Daniel Camarena on 7/21/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    @Binding var selection: String?
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
                    CheckoutView(order: order, selection: $selection)
                }label: {
                    Text("Checkout")
                }.isDetailLink(false)
            }
            .disabled(order.orderData.address.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    @State static var selection: String?
    static var previews: some View {
        AddressView(order: Order(), selection: $selection)
    }
}

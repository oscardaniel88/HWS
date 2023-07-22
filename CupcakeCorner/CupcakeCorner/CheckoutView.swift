//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Daniel Camarena on 7/21/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:  "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                }placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                Text("Your total is \(order.orderData.cost, format: .currency(code: "USD"))")
                Button("Place order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmation){
            Button("OK") {
                dismiss()
            }
        }message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder () async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from:encoded)
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.orderData.quantity)x \(OrderData.types[order.orderData.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        } catch {
            confirmationMessage = "Something went wrong, try again!"
            showingConfirmation = true
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

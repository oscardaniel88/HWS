//
//  ContentView.swift
//  iExpense
//
//  Created by Daniel Camarena on 7/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        return NavigationView {
            List {
                if(!expenses.personalItems.isEmpty){
                    Section(header: Text("Personal expenses")
                        .foregroundColor(.gray)
                        .bold()
                    ){
                        ForEach(expenses.personalItems){
                            item in
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type.stringValue())
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(getColorForAmount(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                if(!expenses.businessItems.isEmpty){
                    Section(header: Text("Business expenses")
                        .foregroundColor(.gray)
                        .bold()
                    ){
                        ForEach(expenses.businessItems){
                            item in
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type.stringValue())
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(getColorForAmount(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingAddExpense = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses)
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.personalItems.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.businessItems.remove(atOffsets: offsets)
    }
    
    func getColorForAmount(amount: Double) -> Color{
        if(amount < 10.0){
            return Color.red
        }
        if(amount >= 10.0 && amount < 100.0 ){
            return Color.blue
        }
        return Color.yellow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

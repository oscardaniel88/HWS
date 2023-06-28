//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Camarena on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage) / 100
        let grandTotal = checkAmount + (checkAmount * tipSelection)
        return grandTotal
    }
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage) / 100
        let grandTotal = checkAmount + (checkAmount * tipSelection)
        let totalPerPerson = grandTotal / peopleCount
        return totalPerPerson
    }
    let currencyFormat = Locale.current.currency?.identifier ?? "USD"
    let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View{
        NavigationView{
            Form{
                Section{
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code:currencyFormat))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) number of people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection:$tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose a tip percentage")
                }
                Section{
                    Text(grandTotal, format: .currency(code:currencyFormat))
                }header: {
                    Text("Total (Check + tip)")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Total per person")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
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

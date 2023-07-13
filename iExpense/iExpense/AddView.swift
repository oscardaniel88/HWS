//
//  AddView.swift
//  iExpense
//
//  Created by Daniel Camarena on 7/13/23.
//

import SwiftUI


struct AddView: View {
    @State private var name = ""
    @State private var type = ExpenseType.Personal
    @State private var amount = 0.0
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(ExpenseType.allCases, id:\.self){ expenseType in
                        let typeText = expenseType.stringValue()
                        Text("\(typeText)")
                            .tag(expenseType)
                    }
                }
                TextField("Amount", value:$amount, format:.currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add a new expense")
            .toolbar {
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}


 struct AddView_Previews: PreviewProvider {
 static var previews: some View {
     AddView(expenses: Expenses())
    }
 }
 

//
//  iExpenseUtils.swift
//  iExpense
//
//  Created by Daniel Camarena on 7/13/23.
//

import Foundation

enum ExpenseType: String, CaseIterable, Codable {
    case Personal = "Personal"
    case Business = "Business"
    
    func stringValue() -> String {
        switch(self) {
        case.Personal:
            return "Personal"
        case .Business:
            return "Business"
        }
    }
    
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey:"Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

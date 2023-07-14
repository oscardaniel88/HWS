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
    @Published var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey:"PersonalItems")
            }
        }
    }
    @Published var businessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey:"BusinessItems")
            }
        }
    }
    init() {
        if let personalSavedItems = UserDefaults.standard.data(forKey: "PersonalItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: personalSavedItems){
                personalItems = decodedItems
            }else{
                personalItems = []
            }
        }
        if let businessSavedItems = UserDefaults.standard.data(forKey: "BusinessItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: businessSavedItems) {
                businessItems = decodedItems
            }else {
                businessItems = []
            }
        }
    }
}

//
//  ExpenseItem.swift
//  Project-7-iExpense
//
//  Created by Pawel Baranski on 14/01/2023.
//

import Foundation

struct ExpenseItem : Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

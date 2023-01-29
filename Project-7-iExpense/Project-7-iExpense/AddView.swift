//
//  AddView.swift
//  Project-7-iExpense
//
//  Created by Pawel Baranski on 14/01/2023.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var curr = "Euro"
    
    let types = ["Business" , "Personal"]
    let currencies = ["USD", "EUR", "JPY"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $curr){
                    ForEach(currencies, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: curr))
                                .keyboardType(.decimalPad)
                
                
            }.navigationTitle("Add new expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type,
                            amount: amount,
                            currency: curr)
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

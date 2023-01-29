//
//  ContentView.swift
//  Project-7-iExpense
//
//  Created by Pawel Baranski on 14/01/2023.
//

import SwiftUI
       
    
struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                Section{
                    ForEach (expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            VStack{
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: item.currency))
                                  .expenseStyle(for: item)
                        }
                    }.onDelete(perform: removeItems)
                }
                
                Section{
                    ForEach (expenses.items.filter {$0.type == "Business"}) { item in
                        HStack {
                            VStack{
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: item.currency))
                                  .expenseStyle(for: item)
                        }
                    }.onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseStyle: ViewModifier {
    let expenseItem: ExpenseItem

    func body(content: Content) -> some View {
        switch expenseItem.amount {
        case 0..<10:
            content
                .foregroundColor(.green)
        case 10..<100:
            content
                .foregroundColor(.blue)
        default:
            content
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

extension View {
    func expenseStyle(for expenseItem: ExpenseItem) -> some View {
        modifier(ExpenseStyle(expenseItem: expenseItem))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

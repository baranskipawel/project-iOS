//
//  ContentView.swift
//  Project-1-Split
//
//  Created by Pawel Baranski on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercent = 2
    @FocusState private var amountIsFocused : Bool
    let tipOptions = [0, 10, 15, 20, 25]
    
    func calculatedCost(_ type: String) -> Double {
        let people = Double(numberOfPeople + 2)
        let tip = Double(tipOptions[tipPercent]) / 100
        let amount = Double(checkAmount) ?? 0
        if type == "total" {
            return amount * (1 + tip) / people
        } else if type == "tip" {
            return amount * tip
        }
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details:")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Input your tip amount below:")) {
                    Picker("Percent Tip", selection: $tipPercent) {
                        ForEach(0 ..< tipOptions.count) {
                            Text("\(self.tipOptions[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result:")) {
                    Text("\(calculatedCost("total"), specifier: "$%.2f per person")")
                        .font(.title2)
                    Text("Total tip: \(calculatedCost("tip"), specifier: "$%.2f")")
                        .foregroundColor(tipPercent == 0 ? Color.red : Color.gray)
                }
            }
            .navigationBarTitle("WeSplit").toolbar {
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

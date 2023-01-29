//
//  ContentView.swift
//  Project-3-BetterRest
//
//  Created by Pawel Baranski on 09/01/2023.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var rangePick = 1...20
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)){
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                }

                Section(header: Text("Desired amount of sleep")
                    .font(.headline)){
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section(header: Text("Daily coffee intake").font(.headline)){
                        Picker("cups", selection: $coffeeAmount){
                            ForEach(1..<21){ number in Text("\(number)")
                                
                            }
                        }
                }
                
                Section(header: Text("You should go to bed at:").font(.headline.bold())){
                    Text(calculateBedTime())
                }
                
            }.navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            do {
                let config = MLModelConfiguration()
                let model = try BetterRestCalculator(configuration: config)
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                let sleepTime = wakeUp - prediction.actualSleep

                let formatter = DateFormatter()
                formatter.timeStyle = .short

                return formatter.string(from: sleepTime)
            } catch {
                return "Sorry, there was a problem calculating your bedtime."
            }
      }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

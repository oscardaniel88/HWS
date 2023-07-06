//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Camarena on 7/5/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Wake up").font(.headline)){
                    HStack {
                        Text("Choose a time")
                        Spacer()
                        DatePicker("Please enter a time", selection:$wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                    }
                }
                Section(header: Text("Sleep Amount").font(.headline)){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step:0.25)
                }
                Section(header: Text("Coffee intake").font(.headline)){
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value:$coffeeAmount, in: 1...20, step: 1)
                }
                
                Section(header: Text("Result").font(.headline)){
                    HStack {
                        Text("Your ideal bedtime is…")
                        Spacer()
                        Text("\(calculateBedTime)").font(.title)
                    }
                }
            }
        }
    }
    
    var calculateBedTime: String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

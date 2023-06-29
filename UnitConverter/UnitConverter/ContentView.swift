//
//  ContentView.swift
//  UnitConverter
//
//  Created by Daniel Camarena on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputSource = 0.0
    @State private var outputTarget = 0.0
    @State private var sourceUnit = "m"
    @State private var targetUnit = "m"
    let sourceUnits = ["m", "km", "ft", "yd", "mi"]
    let targetUnits = ["m", "km", "ft", "yd", "mi"]
    @FocusState private var inputIsFocused: Bool
    var body: some View {
        NavigationView{
            Form{
                Section{
                   TextField("Amount",
                              value: $inputSource,
                             format: .number)
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                }header: {
                    Text("Input")
                }
                Section{
                    Picker("Convert from", selection: $sourceUnit){
                        ForEach(sourceUnits, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header:{
                    Text("Convert from")
                }
                Section{
                    Picker("Convert from", selection: $targetUnit){
                        ForEach(targetUnits, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Convert to")
                }
                Button("Convert"){
                    let sourceToMeters = sourceToMeters()
                    outputTarget = result(inputNumber: sourceToMeters)
                }
                Section{
                    Text("\(outputTarget.formatted())")
                }header: {
                    Text("Result")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    
    func sourceToMeters()->Double{
        if(sourceUnit == "m"){
            return inputSource
        }else if (sourceUnit == "km"){
            return inputSource * 1000
        }else if (sourceUnit == "ft"){
            return inputSource * 0.3048
        }else if (sourceUnit == "yd"){
            return inputSource * 0.9144
        }else {
            return inputSource * 1609.4
        }
    }
    
    func result(inputNumber: Double)-> Double{
        if(targetUnit == "m"){
            return inputNumber
        }else if (targetUnit == "km"){
            return inputNumber / 1000
        }else if (targetUnit == "ft"){
            return inputNumber / 0.3048
        }else if (targetUnit == "yd"){
            return inputNumber / 0.9144
        }else {
            return inputNumber / 1609.4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

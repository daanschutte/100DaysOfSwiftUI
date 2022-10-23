//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Daan Schutte on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var valueToConvert = 1.0
    @State private var baseUnit = "m"
    @State private var targetUnit = "m"
    
    @FocusState private var inputFocused: Bool
    
    let units = ["mm", "cm", "m", "km"]
    
    private var millimeters: Double {
        switch baseUnit {
        case "mm":
            return valueToConvert
        case "cm":
            return valueToConvert * 10
        case "m":
            return valueToConvert * 1000
        case "km":
            return valueToConvert * 1_000_000
        default:
            return 0.0
        }
    }
    
    private var result: Double {
        switch targetUnit {
        case "mm":
            return millimeters
        case "cm":
            return millimeters / 10
        case "m":
            return millimeters / 1000
        case "km":
            return millimeters / 1_000_000
        default:
            return 0.0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter a value", value: $valueToConvert, format: .number)
                        .focused($inputFocused)
                        .keyboardType(.decimalPad)
                    
                    Picker("Convert from", selection: $baseUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Convert from")
                }
                
                Section {
                    Picker("Convert to", selection: $targetUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    Text(result.formatted())
                } header: {
                    Text("Convert to")
                }
                
                
            }.navigationTitle("Absolute Unit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            inputFocused = false
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

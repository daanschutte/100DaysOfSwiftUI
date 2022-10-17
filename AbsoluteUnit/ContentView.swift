//
//  ContentView.swift
//  AbsoluteUnit
//
//  Created by Daan Schutte on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var valueToConvert = 0.0
    @State private var selectedConversion = "ºC to ºF"
    
    @FocusState private var inputFocused: Bool
    
    
    let conversion = ["ºC to ºF", "ºF to ºC", "Kg to lbs", "lbs to Kg"]
    
    var celciusToFarenheit: Double {
        valueToConvert * 1.8 + 32.0
    }
    
    var farenheitToCelcius: Double {
        (valueToConvert - 32) * 1.8
    }
    
    var kilogramsToPounds: Double {
        valueToConvert * 2.205
    }
    
    var poundsToKilograms: Double {
        valueToConvert / 2.205
    }
    
    var result: Double {
        switch selectedConversion {
        case "ºC to ºF":
            return celciusToFarenheit
        case "ºF to ºC":
            return farenheitToCelcius
        case "Kg to lbs":
            return kilogramsToPounds
        case "lbs to Kg":
            return poundsToKilograms
            
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter a value", value: $valueToConvert, format: .number)
                        .focused($inputFocused)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter a value to convert")
                }
                
                Section {
                    Picker("Conversion type", selection: $selectedConversion) {
                        ForEach(conversion, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select conversion type")
                }
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Result")
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

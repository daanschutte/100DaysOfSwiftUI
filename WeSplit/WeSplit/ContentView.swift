//
//  ContentView.swift
//  WeSplit
//
//  Created by Daan Schutte on 16/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocussed: Bool
    
    let currency = Locale.current.currency?.identifier ?? "USD"
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipValue: Double {
        checkAmmount / 100 * Double(tipPercentage)
    }
    
    var grandTotal: Double {
        checkAmmount + tipValue
    }
    
    var totalPerPerson: Double {
        let correctedPeopleCount = Double(numberOfPeople + 2)
        return grandTotal / correctedPeopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmmount, format:
                            .currency(code: currency))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocussed)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currency))
                } header: {
                    Text("Total per person")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: currency))
                        .foregroundColor(tipValue == 0.0 ? .red : .primary)
                } header: {
                    Text("Total to pay")
                }
            }.navigationTitle("WeSplit 2.0")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocussed = false
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

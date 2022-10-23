//
//  ContentView.swift
//  BetterRest
//
//  Created by Daan Schutte on 19/10/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var bedTime = defaultBedTime.formatted(date: .omitted, time: .shortened)
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    static var defaultBedTime: Date {
        var components = DateComponents()
        components.hour = 9
        components.minute = 38
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 0){
                        Text("When do you want to wake up?")
                            .font(.headline)

                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .onChange(of: wakeUp) { _ in
                                calculateBedtime()
                            }
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Desired amount of sleep")
                            .font(.headline)

                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                            .onChange(of: sleepAmount) { _ in
                                calculateBedtime()
                            }
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 0...20)
                            .onChange(of: coffeeAmount) { _ in
                                calculateBedtime()
                            }
                    }
                }
                
                Section {
                    VStack {
                        Text("Your recommended bedtime is")
                            .font(.headline)
                        Text(bedTime)
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            bedTime = "Sorry, there was an error calculating your bedtime"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

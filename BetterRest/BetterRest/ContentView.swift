//
//  ContentView.swift
//  BetterRest
//
//  Created by Manideep Gattamaneni on 12/18/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert: Bool = false
    @State private var idealBedTime = defaultWakeTime
    var body: some View {
        
        NavigationStack {
            Form {
                Section("When do you want to wake up?"){
                    DatePicker("Please enter the date", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                        .onChange(of: wakeUp) {
                            calculateBedTime()
                        }
                }
                
                Section("Desired amount to sleep?"){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount){
                            calculateBedTime()
                        }
                }
                
                Section("Daily coffee intake?"){
                    Picker("Select number of cups", selection: $coffeeAmount){
                        ForEach(1...20, id: \.self) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Your ideal bedtime is"){
                    Text(idealBedTime.formatted(date: .omitted, time: .shortened))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle , isPresented: $showingAlert) {
                Button("OK") {
                    
                }
            } message: {
                Text(alertMessage)
            }
            .onAppear { calculateBedTime() }
        }
    }
    func calculateBedTime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            idealBedTime = sleepTime
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
       // showingAlert = true
        
        
    }
}

#Preview {
    ContentView()
}


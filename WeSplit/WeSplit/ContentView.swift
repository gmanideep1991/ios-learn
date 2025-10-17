//
//  ContentView.swift
//  WeSplit
//
//  Created by Manideep Gattamaneni on 10/13/25.
//

import SwiftUI

struct ContentView: View {
    
//    One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
//
//        Add a header to the third section, saying “Amount per person”
//        Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
//        Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var isAmountCheckFocused:Bool
   // let tipPercentages: [Int] = [5, 10, 15, 18, 20, 25, 30]
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountCheckFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Total Amount with tip") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if(isAmountCheckFocused){
                    Button("Done") {
                        isAmountCheckFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

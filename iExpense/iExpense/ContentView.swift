//
//  ContentView.swift
//  iExpense
//
//  Created by Manideep Gattamaneni on 12/22/25.
//

import Observation
import SwiftUI

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    var body: some View {
        NavigationStack {
            List {
                Section("Business Expenses"){
                    if(expenses.getBusinessItems().isEmpty){
                        Text("No Business Expenses to show")
                    }
                    ForEach(expenses.getBusinessItems()) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }

                            Spacer()
                            Text(item.amount, format: .localCurrencyOrUSD)
                                .foregroundColor(
                                    item.amount < 10
                                        ? .green
                                        : item.amount < 100 ? .indigo : .red
                                )
                        }
                    }
                    .onDelete(perform: removeBusinessItem)
                }
                
                Section("Personal Expenses"){
                    if(expenses.getPersonalItems().isEmpty){
                        Text("No Personal Expenses to show")
                    }
                    ForEach(expenses.getPersonalItems()) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }

                            Spacer()
                            Text(item.amount, format: .localCurrencyOrUSD)
                                .foregroundColor(
                                    item.amount < 10
                                        ? .green
                                        : item.amount < 100 ? .indigo : .red
                                )
                        }
                    }
                    .onDelete(perform: removePersonalItem)
                }
            }
            NavigationLink("Add Expense"){
                AddView(expenses: expenses)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)){
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeBusinessItem(at offsets: IndexSet) {
        if let index = offsets.first {
            let item = expenses.getBusinessItems()[index]
            expenses.items.removeAll{$0.id == item.id}
        }
    }
    
    func removePersonalItem(at offsets: IndexSet) {
        if let index = offsets.first {
            let item = expenses.getPersonalItems()[index]
            expenses.items.removeAll{$0.id == item.id}
        }
    }
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "expenses")
            }
        }
    }
    init() {
        if let savedExpenses = UserDefaults.standard.data(forKey: "expenses") {
            if let decodedExpenses = try? JSONDecoder().decode(
                [ExpenseItem].self,
                from: savedExpenses
            ) {
                items = decodedExpenses
                return
            }
        }
        items = []
    }
    func getBusinessItems() -> [ExpenseItem] {
        return items.filter { $0.type == ExpenseType.Business.rawValue }
    }
    func getPersonalItems() -> [ExpenseItem] {
        return items.filter { $0.type == ExpenseType.Personal.rawValue }
    }
}

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

#Preview {
    ContentView()
}

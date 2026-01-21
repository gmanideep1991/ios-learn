//
//  AddView.swift
//  iExpense
//
//  Created by Manideep Gattamaneni on 1/20/26.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses
    @State private var name = ""
    @State private var amount: Double = 0.0
    @State private var type = ExpenseType.Personal

    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Amount", value: $amount, format: .localCurrencyOrUSD)
                    .keyboardType(.decimalPad)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    expenses.items.append(
                        ExpenseItem(
                            name: name,
                            type: type.rawValue,
                            amount: amount
                        )
                    )
                    dismiss()
                }
            }
        }
    }
}
enum ExpenseType: String, CaseIterable {
    case Personal
    case Business
}

#Preview {
    AddView(expenses: Expenses())
}

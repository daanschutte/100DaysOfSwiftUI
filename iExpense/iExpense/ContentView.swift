//
//  ContentView.swift
//  iExpense
//
//  Created by Daan Schutte on 28/10/2022.
//

import SwiftUI

struct ExpenseItemListView: View {
    
    @ObservedObject var expenses: Expenses
    
    let expenseType: String
    
    var body: some View {
        List {
            ForEach(expenses.items) { item in
                if item.type == expenseType {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundColor(getForegroundColor(item.amount))
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(item.name), \(item.amount)")
                    .accessibilityHint("\(item.type)")
                }
            }
            .onDelete(perform: removeItems)
        }
    }
        
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    
    func getForegroundColor(_ amount: Double) -> Color {
        switch amount {
        case 0...9.99:
            return .green
        case 10...99.99:
            return .orange
        case 100...Double.greatestFiniteMagnitude:
            return .red
        default:
            return .primary
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var types = ["Personal", "Business"]
    @State private var type = "Personal"
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                ExpenseItemListView(expenses: expenses, expenseType: type)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

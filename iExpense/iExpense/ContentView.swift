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
            ForEach(expenses.itemsByType(expenseType)) { item in
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
            }
            .onDelete(perform: removeItems)
        }
    }
    
    
    func removeItems(at offsets: IndexSet) {
        //        expenses.remove(atOffsets: offsets)
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
    
    var body: some View {
        NavigationStack {
            VStack {
                // TODO: toggle with a picker
                ExpenseItemListView(expenses: expenses, expenseType: "Personal")
                ExpenseItemListView(expenses: expenses, expenseType: "Business")
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

//
//  Expenses.swift
//  iExpense
//
//  Created by Daan Schutte on 30/10/2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}


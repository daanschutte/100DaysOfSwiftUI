//
//  ContentView.swift
//  iExpense
//
//  Created by Daan Schutte on 28/10/2022.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

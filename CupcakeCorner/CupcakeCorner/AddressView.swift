//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Daan Schutte on 14/11/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderClass: OrderClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderClass.order.name)
                TextField("Street address", text: $orderClass.order.streetAddress)
                TextField("City", text: $orderClass.order.city)
                TextField("Zip", text: $orderClass.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderClass: orderClass)
                } label: {
                    Text("Check out")
                }
                .disabled(!orderClass.order.hasValidAddress)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddressView(orderClass: OrderClass())
        }
    }
}

//
//  Order.swift
//  CupcakeCorner
//
//  Created by Daan Schutte on 14/11/2022.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasInvalidAddress: Bool {
         return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty
    }
    
    var cost: Double {
        // @ $2 per cupcake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 extra per cupcake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 extra per cupcake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

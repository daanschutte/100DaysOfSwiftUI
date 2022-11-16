//
//  Order.swift
//  CupcakeCorner
//
//  Created by Daan Schutte on 14/11/2022.
//

import SwiftUI

class OrderClass: ObservableObject {
    @Published var order = Order()
    
    init() {
        order = Order(
            type: 0,
            quantity: 3,
            specialRequestEnabled: false,
            extraFrosting: false,
            addSprinkles: false,
            name: "",
            streetAddress: "",
            city: "",
            zip: "")
    }
    
}

struct Order: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
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

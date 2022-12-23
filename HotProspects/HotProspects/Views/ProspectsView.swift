//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Daan Schutte on 23/12/2022.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType

    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle(title)
        }
    }
    
    var title: String {
        switch filter {
            case .none:
                return "Everyone"
            case .contacted:
                return "Contacted people"
            case .uncontacted:
                return "Uncontacted people"
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}

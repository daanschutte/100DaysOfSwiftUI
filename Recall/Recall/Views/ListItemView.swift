//
//  ListItemView.swift
//  Recall
//
//  Created by Daan Schutte on 19/12/2022.
//

import SwiftUI

struct ListItemView: View {
    var person: Person
    
    var body: some View {
        HStack {
            person.image?
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(person.name)
            
            Spacer()
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static let person = Person(id: UUID(), name: "Bezoz", image: Image("example"))
    
    static var previews: some View {
        ListItemView(person: person)
    }
}

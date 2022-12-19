//
//  ListItemView.swift
//  Recall
//
//  Created by Daan Schutte on 19/12/2022.
//

import SwiftUI

struct ListItemView: View {
     var name: String
     var image: Image
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(name)
            
            Spacer()
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static let image = Image("example")
    
    static var previews: some View {
        ListItemView(name: "George", image: image)
    }
}

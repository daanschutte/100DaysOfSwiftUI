//
//  CrewView.swift
//  Moonshot
//
//  Created by Daan Schutte on 04/11/2022.
//

import SwiftUI

struct CrewView: View {
    let astronaut: Astronaut
    let role: String
    
    var body: some View {
        VStack {
            HStack {
                Image(astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(astronaut.name)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(role)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CrewView(astronaut: astronauts["armstrong"]!, role: "Commander")
            .preferredColorScheme(.dark)
    }
}

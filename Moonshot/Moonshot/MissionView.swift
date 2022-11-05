//
//  MissionView.swift
//  Moonshot
//
//  Created by Daan Schutte on 04/11/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.63)
                        .padding(.vertical)
                    
                    Text("Mission date: \(mission.formattedLaunchDate)")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        HorizontalDivider()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        HorizontalDivider()
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackGround)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[2])
            .preferredColorScheme(.dark)
    }
}

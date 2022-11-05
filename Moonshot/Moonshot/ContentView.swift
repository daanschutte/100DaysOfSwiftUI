//
//  ContentView.swift
//  Moonshot
//
//  Created by Daan Schutte on 01/11/2022.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                    .padding(.vertical, 5)
                }
            }
            .background(.darkBackGround)
            .padding()
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission)
            } label: {
                HStack {
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 55)
                        .padding(.horizontal)
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.darkBackGround)
        }
        .scrollContentBackground(.hidden)
    }
}

struct ContentView: View {
    @State private var showingListLayout = false
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            Group {
                if showingListLayout {
                    ListLayout(missions: missions)
                } else {
                    GridLayout(missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackGround)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button(showingListLayout ? "Grid View" : "List View") {
                        showingListLayout.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

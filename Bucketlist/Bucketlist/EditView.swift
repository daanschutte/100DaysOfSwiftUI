//
//  EditView.swift
//  Bucketlist
//
//  Created by Daan Schutte on 15/12/2022.
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                        case .loading:
                            Text("Loading...")
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ")
                                + Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("Failed to load")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = Location(
                        id: UUID(),
                        name: name,
                        description: description,
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: location)
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}

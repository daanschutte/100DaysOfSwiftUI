//
//  NameInputView.swift
//  Recall
//
//  Created by Daan Schutte on 18/12/2022.
//

import SwiftUI

// Not the prettiest, playing with modifiers
struct NameInputView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var name: String
    
    let image: Image?
    
    var body: some View {
        VStack {
            HStack {
                Text("Add person")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                Spacer()
            }
            
            image?
                .resizable()
                .scaledToFit()
                .padding(10)
                .border(.brown)
                .rotationEffect(Angle(degrees: 2))
                .padding()
            
            TextField("Enter name:", text: $name)
                .padding()
            
            Button("Ok") {
                dismiss()
            }
            
        }
    }
}

struct NameInputView_Previews: PreviewProvider {
    @State static var name = ""
    static var previews: some View {
        NavigationStack {
            NameInputView(name: $name, image: Image("example"))
        }
    }
}

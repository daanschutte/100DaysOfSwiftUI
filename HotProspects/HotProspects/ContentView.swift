//
//  ContentView.swift
//  HotProspects
//
//  Created by Daan Schutte on 22/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

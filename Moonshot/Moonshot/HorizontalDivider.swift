//
//  SpacerView.swift
//  Moonshot
//
//  Created by Daan Schutte on 04/11/2022.
//

import SwiftUI

struct HorizontalDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct SpacerView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDivider()
    }
}

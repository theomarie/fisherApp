//
//  InformationIcon.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI

struct InformationIcon: View {
    
    @State  var icon: Image = Image(systemName: "ruler.fill")
    @State  var informationTitle: String = "Taille"
    @State  var informationBody: String = "30 cm"


    var body: some View {
        VStack {
            HStack {
                icon
                Text(informationTitle)
                    .font(.headline)

            }
            Text(informationBody)
                .font(.subheadline)

        }
    }
}

#Preview {
    InformationIcon()
}

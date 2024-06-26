//
//  StatView.swift
//  fisherApp
//
//  Created by Theo Marie on 26/06/2024.
//

import SwiftUI

struct StatView: View, Identifiable {
    let id = UUID()
    var statName: String
    var statValue: String
    var iconValue: String = "calendar"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(statName)
                    .font(.subheadline)
                .foregroundColor(.gray)
                Spacer()
                Image(systemName: iconValue)
                    .foregroundStyle(Color(.accent))
                    

            }
            
            Text(statValue)
                .font(.headline)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}


#Preview {
        StatView(statName: "Pêcher", statValue: "12-01-2024")
            .padding(100)
}

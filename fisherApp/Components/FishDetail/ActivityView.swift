//
//  ActivityView.swift
//  fisherApp
//
//  Created by Theo Marie on 26/06/2024.
//

import SwiftUI

struct ActivityView: View {
    var activityName: String
    var activityValue: String
    var iconValue: String
    
    var body: some View {
        HStack {
            Text(activityName)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            Text(activityValue)
                .font(.headline)
            Image(systemName: iconValue)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    ActivityView(activityName: "Taille minimun", activityValue: "23 cm", iconValue: "ruler")
}

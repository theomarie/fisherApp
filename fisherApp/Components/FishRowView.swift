//
//  HomeView.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI

struct FishRowView: View {
     var fish: Fish

    

    var body: some View {
        HStack {
            Image(fish.picture)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(fish.title)
                    .font(.headline)
                Text(fish.breed.name)
                    .font(.subheadline)
                Text(fish.date)
                    .font(.subheadline)
            }
            
        }
    
    }
    
    
}

#Preview {
    FishRowView(fish: Fish(title: "Salmon red", breed: Breed(name: "Salmon", minSize: 22.1, maxSize: 43.3, fishable: true, storageTemp: "0-4°C"), size: 24, date: "2024-12-01", picture: "Gold Fish45"))
}

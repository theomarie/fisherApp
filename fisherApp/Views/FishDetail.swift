//
//  FishDetail.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI

struct FishDetail: View {
    
    @State private var fish: Fish = Fish(title: "Patoche", race: "Red fish", date: "2023-07-20", picture: "Bangus91")

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image(fish.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(16.0)
                        .padding()
                    
                    VStack {
                        Text("dssdffsdf")
                        Text("dssdffsdf")

                    }
                  
                    Spacer()
                    
                }
            }
           
                .navigationBarTitle(fish.title, displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    FishDetail()
}

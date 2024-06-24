//
//  HomeView.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searchText: String = ""
    @State private var fishes: [Fish] = []
    
    var filteredFishes: [Fish] {
            if searchText.isEmpty {
                return fishes
            } else {
                return fishes.filter { $0.title.contains(searchText) || $0.race.contains(searchText) }
            }
        }

    var body: some View {
        NavigationView {
            List(filteredFishes) { fish in
                            HStack {
                                Image(fish.picture)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(fish.title)
                                        .font(.headline)
                                    Text(fish.race)
                                        .font(.subheadline)
                                    Text(fish.date)
                                        .font(.subheadline)
                                   
                                }
                                Spacer()
                                Image(systemName: "control")
                                    .rotationEffect(Angle(degrees: 90.0))
                            }
                        }
            .searchable(text: $searchText, prompt: "Rechercher")
                        .navigationBarTitle("Historique", displayMode: .large)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .onAppear(perform: loadFishes)
            
    }
    
    
    func loadFishes() {
            guard let url = Bundle.main.url(forResource: "dataFish", withExtension: "json") else {
                print("JSON file not found")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                fishes = try decoder.decode([Fish].self, from: data)
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    
}








#Preview {
    HomeView()
}

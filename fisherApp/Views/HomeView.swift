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
    @State private var showCamera = false
    @State var selectedImage: UIImage?

    
    var filteredFishes: [Fish] {
        if searchText.isEmpty {
            return fishes
        } else {
            return fishes.filter { $0.title.contains(searchText) || $0.breed.name.contains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
           
        
             List(filteredFishes) { fish in
                 let index = fishes.firstIndex(where: {$0.id == fish.id})
                 NavigationLink(destination: FishDetail(fish:  $fishes[index!])) {
                     FishRowView(fish: fish)
                 }
             }
            
            
            .searchable(text: $searchText, prompt: "Rechercher")
            .navigationBarTitle("Historique", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.showCamera.toggle()
                    }) {
                        Image(systemName: "camera")
                    }.fullScreenCover(isPresented: $showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                        .navigationDestination(item: $selectedImage) { image in
                                AnalyseView(fishImg: $selectedImage)
                            }
                        
                    }
                }
            }
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

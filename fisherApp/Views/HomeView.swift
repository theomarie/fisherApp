//
//  HomeView.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var searchText: String = ""
    @State private var showCamera = false
    @State var selectedImage: UIImage?
    @Query var fishData: [FishSaved_Model]
    @State private var showFavoritesOnly = false
    @State private var sortOrder: SortOrder = .none
    
    enum SortOrder {
        case none, dateAscending, dateDescending
    }
    /*
     var filteredFishes: [FishSaved_Model] {
     if searchText.isEmpty {
     return fishData
     } else {
     return fishData.filter { $0.title.contains(searchText) || $0.breed.name.contains(searchText) }
     }
     }
     */
    
    var filteredFishes: [FishSaved_Model] {
        var result = fishData
        
        if showFavoritesOnly {
            result = result.filter { $0.isFavorite }
        }
        
        if !searchText.isEmpty {
            result = result.filter { $0.title.contains(searchText) || $0.breed.name.contains(searchText) }
        }
        
        switch sortOrder {
        case .dateAscending:
            result.sort { $0.date < $1.date }
        case .dateDescending:
            result.sort { $0.date > $1.date }
        case .none:
            break
        }
        
        return result
    }
    
    func delete(at offsets: IndexSet) {
        // delete the objects here
    }
    
    
    var body: some View {
        NavigationStack {
            List(filteredFishes) { fish in
                NavigationLink(destination: FishDetail(fish:  fish)) {
                    FishRowView(fish: fish )
                }
                .swipeActions {
                    Button {
                        fish.isFavorite.toggle()
                    } label: {
                        Label("Favorite", systemImage: fish.isFavorite ? "heart.fill" : "heart")
                    }
                    .tint(.red)
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
    }
}


#Preview {
    let preview = Preview(FishSaved_Model.self)
    preview.addExamples()
    return HomeView()
        .modelContainer(preview.container)
}


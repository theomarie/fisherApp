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
    
    
    
    var filteredFishes: [FishSaved_Model] {
        if searchText.isEmpty {
            return fishData
        } else {
            return fishData.filter { $0.title.contains(searchText) || $0.breed.name.contains(searchText) }
        }
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


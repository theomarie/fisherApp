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
    
    enum SortOrder: String, CaseIterable, Identifiable {
        
           case none = "Aucun tri"
           case dateAscending = "Date (Ascendant)"
           case dateDescending = "Date (Descendant)"
        var id: Self { self }

       }
   
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
                        withAnimation {
                            fish.isFavorite.toggle()
                            print(fish.isFavorite)
                        }
                        
                    } label: {
                        Label("Favorite", systemImage: fish.isFavorite ? "heart.slash.fill" : "heart")
                        
                        
                    }
                    .tint(.accent)
                }
            }
            
            .searchable(text: $searchText, prompt: "Rechercher")
            .navigationBarTitle("Historique", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                                    Menu {
                                        Toggle(isOn: $showFavoritesOnly) {
                                            Label("Favoris uniquement", systemImage: "heart.fill")
                                        }
                                        
                                        Menu("Trier par") {
                                            Picker("Trier par", selection: $sortOrder) {
                                                ForEach(SortOrder.allCases) { order in
                                                    Text(order.rawValue).tag(order)
                                                }
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "line.3.horizontal.decrease.circle")
                                    }
                                }
                    
                    
                   
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
    

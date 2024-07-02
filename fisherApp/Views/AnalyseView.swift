//
//  AnalyseView.swift
//  fisherApp
//
//  Created by Theo Marie on 20/06/2024.
//

import SwiftUI
import CoreML
import os.log
import SwiftData




struct AnalyseView: View {
    @Environment(\.modelContext) var context
    @Query private var breeds: [BreedSaved_Model]
    @State var fish: FishSaved_Model?
    @Binding var fishImg: UIImage?
    @State private var classificationResult: String? = nil
    @State private var isAnalysisComplete = false
    private let fishDetector = FishDetectorModel()
    @State private var showingImagePicker = false
    @Binding var showCamera: Bool
    @State private var showHome = false
    @State private var shouldReleaseFish = false

        
    
   
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let fishImg {
                    Image(uiImage: fishImg)
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                        .clipShape(.circle)
                        .overlay(
                        Circle()
                        .stroke(shouldReleaseFish ? Color.red : Color.clear, lineWidth: 4)
                                            )
                }
                
                
                Text(classificationResult ?? "Classification en cours...")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Spacer()
                if isAnalysisComplete {
                    VStack(spacing: 20) {
                        Button(action: {
                            fishImg = nil
                            self.showCamera.toggle()
                        }) {
                            Label("Reprendre une photo", systemImage: "camera")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(.bordered)
                        .containerRelativeFrame(.horizontal, count: 3, span: 2, spacing: 10)
                        
                        if fish != nil {
                            Button(action: saveAndDismiss) {
                                Label("Enregistrer", systemImage: "square.and.arrow.down")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                
                            }.fullScreenCover(isPresented: $showHome, content: {
                                HomeView()
                            })
                            .buttonStyle(.borderedProminent)
                            .containerRelativeFrame(.horizontal, count: 3, span: 2, spacing: 10)
                        }
                        
                    }
                }
            }
            .padding()
            .onAppear {
                if let fishImg = fishImg {
                    classifyImage(image: fishImg)
                }
            }
            
        }
        Spacer()
    }
    
    private func saveAndDismiss() {
        if let fish = fish {
            context.insert(fish)
            self.showHome.toggle()        }
    }
    
    private func classifyImage(image: UIImage) {
        isAnalysisComplete = false
        fishDetector.classify(image: image) { result in
            DispatchQueue.main.async {
                if let result = result {
                    classificationResult = "Résultat: \(result)"
                    createFishIfBreedExists(breedName: result)
                } else {
                    classificationResult = "Impossible de classifier l'image"
                }
                isAnalysisComplete = true
                print(String(result ?? "no result"))
            }
        }
    }
    
    private func createFishIfBreedExists(breedName: String) {
        if let breed = breeds.first(where: { $0.name.lowercased() == breedName.lowercased() }) {
            
            let size = Double.random(in: 2.0...70.0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: Date())
            
            guard let fishImg = fishImg else {
                       classificationResult = "Erreur : Aucune image à sauvegarder"
                       return
                   }
            
            guard let imageUrl = saveImage(fishImg) else {
                        classificationResult = "Erreur lors de la sauvegarde de l'image"
                        return
                    }
            
            let newFish = FishSaved_Model(
                title: "\(breed.name) \(dateString)",
                breed: breed,
                size: (size * 100).rounded() / 100,
                date: dateString,
                isFavorite: false,
                picture: imageUrl
            )
            
            do {
                try context.save()
            }catch {
                print(error)
            }
            
            fish = newFish
            //shouldReleaseFish = newFish.size >= newFish.breed.minSize && newFish.size <= newFish.breed.maxSize && newFish.breed.fishable

        } else {
            classificationResult = "Impossible d'identifier l'espèce dans notre base de données."
        }
    }
    
    
}




#Preview {
    AnalyseView(fish: FishSaved_Model(title: "Patoche", breed: BreedSaved_Model(name: "Yellowfin", minSize: 11.1, maxSize: 20.2, fishable: true, storageTemp: "0-5°C"), size: 13.8, date: "2023-07-20", isFavorite: false, picture: "Gold Fish42"), fishImg: .constant(UIImage(named: "Gold Fish42")), showCamera: .constant(false))
}

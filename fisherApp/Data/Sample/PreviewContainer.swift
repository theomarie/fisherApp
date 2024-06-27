//
//  PreviewContainer.swift
//  fisherApp
//
//  Created by Theo Marie on 27/06/2024.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create preview container")
        }
    }
    
   
    
    func loadJSONData() -> [Fish]? {
        guard let url = Bundle.main.url(forResource: "dataFish", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let fishArray = try decoder.decode([Fish].self, from: data)
            return fishArray
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func addExamples() {
        
        guard let fishArray = loadJSONData() else {
            print("Failed to load JSON data")
            return
        }
        
        print(fishArray.count)
        
        
        Task { @MainActor in
            fishArray.forEach { fish in
                
                let breedModel = BreedSaved_Model(
                    name: fish.breed.name,
                    minSize: fish.breed.minSize,
                    maxSize: fish.breed.maxSize,
                    fishable: fish.breed.fishable,
                    storageTemp: fish.breed.storageTemp
                )
                
                let fishModel = FishSaved_Model(
                    title: fish.title,
                    breed: breedModel,
                    size: fish.size,
                    date: fish.date,
                    isFavorite: fish.isFavorite ?? false,
                    picture: fish.picture
                )
                
                container.mainContext.insert(fishModel)
            }
        }
    
    /*
    func addExamples(_ examples: [any PersistentModel]) {
        
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
     */
    }
}

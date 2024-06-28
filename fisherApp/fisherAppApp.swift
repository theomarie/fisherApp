//
//  fisherAppApp.swift
//  fisherApp
//
//  Created by Theo Marie on 18/06/2024.
//

import SwiftUI
import SwiftData


@main
struct fisherAppApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([FishSaved_Model.self, BreedSaved_Model.self])
        let config = ModelConfiguration("MyFish", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
            initializeSwiftDataModels(context: container.mainContext)
        } catch {
            fatalError("Could not configure the container: \(error)")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    func initializeSwiftDataModels(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<FishSaved_Model>(predicate: nil)
        let count = (try? context.fetchCount(fetchDescriptor)) ?? 0
        
        if count == 0 {
            print("Database is empty. Loading sample data...")
            guard let fishArray = loadJSONData() else {
                print("Failed to load JSON data")
                return
            }
            
            for fish in fishArray {
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
                
                context.insert(breedModel)
                context.insert(fishModel)
            }
            
            do {
                try context.save()
                print("Data successfully saved to SwiftData")
            } catch {
                print("Failed to save data to SwiftData: \(error)")
            }
        } else {
            print("Database already contains \(count) records.")
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
}
    
    
 

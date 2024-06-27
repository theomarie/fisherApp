//
//  breed.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import Foundation

import SwiftUI
import SwiftData

struct Breed: Identifiable, Codable {
    var id = UUID()
    let name: String
    let minSize: Double
    let maxSize: Double
    let fishable: Bool
    let storageTemp: String
    var statsBreed : [Stat] {
        [
            Stat( statName: "Espèce pechable", statValue: fishable ? "Oui" : "Non" , iconValue: "figure.fishing"),
            Stat( statName: "Taille minimun", statValue: "\(minSize) cm", iconValue: "ruler"),
            Stat(statName: "Taille Maximun", statValue: "\(maxSize) cm", iconValue: "ruler"),
            Stat(statName: "Conservation", statValue: storageTemp, iconValue: "snowflake")
            
        ]
    }
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case minSize
        case maxSize
        case fishable
        case storageTemp
    }
    
}

@Model
final class BreedSaved_Model {
    var id = UUID()
    let name: String
    let minSize: Double
    let maxSize: Double
    let fishable: Bool
    let storageTemp: String
    var statsBreed : [Stat] {
        [
            Stat( statName: "Espèce pechable", statValue: fishable ? "Oui" : "Non" , iconValue: "figure.fishing"),
            Stat( statName: "Taille minimun", statValue: "\(minSize) cm", iconValue: "ruler"),
            Stat(statName: "Taille Maximun", statValue: "\(maxSize) cm", iconValue: "ruler"),
            Stat(statName: "Conservation", statValue: storageTemp, iconValue: "snowflake")
            
        ]
    }
    
    
    init(id: UUID = UUID(), name: String, minSize: Double, maxSize: Double, fishable: Bool, storageTemp: String) {
        self.id = id
        self.name = name
        self.minSize = minSize
        self.maxSize = maxSize
        self.fishable = fishable
        self.storageTemp = storageTemp
    }
}

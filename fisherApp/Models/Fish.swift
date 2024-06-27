//
//  Fish.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct Fish: Identifiable, Codable, Hashable {
   
    
    var id = UUID()
    var title: String
    var breed: Breed
    var size: Double
    let date: String
    let picture: String
    var stats : [Stat] {
        [ Stat( statName: "Pêcher", statValue: date, iconValue: "calendar"),
          Stat(statName: "Espèce", statValue: breed.name, iconValue: "pawprint.circle.fill"),
          Stat(statName: "Taille", statValue: displaySize(), iconValue: "ruler")]
    }
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
    
    static func == (lhs: Fish, rhs: Fish) -> Bool {
        return lhs.id == rhs.id

    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case breed
        case size
        case date
        case picture
    }
    
    func displaySize() -> String {
       return "\(size) cm"
    }
     
}

@Model 
final class FishSaved_Model {
    var id = UUID()
    var title: String
    var breed: BreedSaved_Model
    var size: Double
    let date: String
    let picture: String
    var stats : [Stat] {
        [ Stat( statName: "Pêcher", statValue: date, iconValue: "calendar"),
          Stat(statName: "Espèce", statValue: breed.name, iconValue: "pawprint.circle.fill"),
          Stat(statName: "Taille", statValue: displaySize(), iconValue: "ruler")]
    }
    
    func displaySize() -> String {
       return "\(size) cm"
    }
    
    
    init(id: UUID = UUID(), title: String, breed: BreedSaved_Model, size: Double, date: String, picture: String) {
        self.id = id
        self.title = title
        self.breed = breed
        self.size = size
        self.date = date
        self.picture = picture
    }
}






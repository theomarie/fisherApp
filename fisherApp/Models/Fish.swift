//
//  Fish.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import Foundation
import SwiftUI

struct Fish: Identifiable, Codable, Hashable {
    static func == (lhs: Fish, rhs: Fish) -> Bool {
        return lhs.id == rhs.id

    }
    
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


struct Stat: Identifiable, Codable {
    var id = UUID()
    var statName: String
    var statValue: String
    var iconValue: String
    
   
    
   
     
}




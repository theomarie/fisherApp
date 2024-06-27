//
//  StatProtocol.swift
//  fisherApp
//
//  Created by Theo Marie on 26/06/2024.
//

import Foundation



struct Stat: Identifiable, Codable {
    var id = UUID()
    var statName: String
    var statValue: String
    var iconValue: String
   
}

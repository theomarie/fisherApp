//
//  Fish.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import Foundation
import SwiftUI

import SwiftUI

struct Fish: Identifiable, Codable {
    var id = UUID()
    var title: String
    var race: String
    let date: String
    let picture: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case race
        case date
        case picture
    }
}



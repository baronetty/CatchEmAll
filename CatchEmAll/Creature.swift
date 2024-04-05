//
//  Creature.swift
//  CatchEmAll
//
//  Created by Leo  on 03.04.24.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String // url for detail on Pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}

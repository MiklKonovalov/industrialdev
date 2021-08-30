//
//  Planet.swift
//  Navigation
//
//  Created by Misha on 30.08.2021.
//

import Foundation

struct Planet: Decodable {
    var name: String
    var rotation: String
    var orbital: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotation = "rotation_period"
        case orbital = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surface = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
    
}

struct Net {
    var completed: Int
    var id: Int
    var title: String
    var userID: Int
    
    init(json: [String: Any]) {
        completed = json["completed"] as? Int ?? -1
        id = json["id"] as? Int ?? -1
        title = json["title"] as? String ?? ""
        userID = json["userID"] as? Int ?? -1
    }
}


//
//  TMDBRRemoteBreed.swift
//  CatLib
//
//  Created by user on 18/08/23.
//

import Foundation

struct Breed: Decodable {
    let id: String
    let name: String
    let origin: String
    let description: String
    let weight: Weight
    let temperament: String
    let lifeSpan: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, weight, temperament, origin
        case lifeSpan = "life_span"

    }

    struct Weight: Decodable {
        let metric: String
    }
}

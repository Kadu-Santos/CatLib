//
//  TMDBRRemoteBreed.swift
//  CatLib
//
//  Created by user on 18/08/23.
//

import Foundation

struct TMDBRemoteCat: Decodable {
    let breeds: [Breed]
    let url: String
}

//
//  RMGetCharactersResponse.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 07.04.2023.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    
    let info: Info
    let results: [RMCharacter]
    
    struct Info: Codable {
            let count: Int
            let pages: Int
            let next: String?
            let prev: String?
    }
}

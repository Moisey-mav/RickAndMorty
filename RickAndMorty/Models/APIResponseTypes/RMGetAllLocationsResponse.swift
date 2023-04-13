//
//  RMGetAllLocationsResponse.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 12.04.2023.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    
    let info: Info
    let results: [RMLocation]
    
    struct Info: Codable {
            let count: Int
            let pages: Int
            let next: String?
            let prev: String?
    }
}

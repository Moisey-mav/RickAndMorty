//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 10.04.2023.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    
    let info: Info
    let results: [RMEpisode]
    
    struct Info: Codable {
            let count: Int
            let pages: Int
            let next: String?
            let prev: String?
    }
}

//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 07.04.2023.
//

import Foundation

/// Represent unique API endpoint
@frozen enum RMEndpoint: String {
    case character
    case location
    case episode
}

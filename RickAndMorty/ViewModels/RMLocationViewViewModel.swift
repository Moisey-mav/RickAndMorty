//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 12.04.2023.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    // Location response info
    
    private var cellViewModels: [String] = []
    
    init() {}
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequset, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}

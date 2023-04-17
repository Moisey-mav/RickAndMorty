//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 17.04.2023.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episode([RMCharacterEpisodeCollectionViewCellViewModel])
}

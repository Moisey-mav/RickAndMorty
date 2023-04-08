//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 08.04.2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.dowloadImage(imageUrl, completion: completion)
    }
}

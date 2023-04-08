//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 07.04.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(comletion: @escaping(Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = characterImageUrl else {
            comletion(.failure(URLError(.badURL)))
            return
        }
        
        let rquest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: rquest) { data, _, error in
            guard let data = data, error == nil else {
                comletion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            comletion(.success(data))
        }
        task.resume()
    }
}

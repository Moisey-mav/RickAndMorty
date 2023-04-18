//
//  RMSearchResultType.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 17.04.2023.
//

import Foundation

final class RMSearchResultViewModel {
    public private(set) var results: RMSearchResultType
    private var next: String?
    
    init(results: RMSearchResultType, next: String?) {
        self.results = results
        self.next = next
        print(next)
    }
    
    public private(set) var isLoadingMoreResults = false
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    public func fetchAdditionalLocations(comletion: @escaping([RMLocationTableViewCellViewModel]) -> Void) {
        guard !isLoadingMoreResults else { return }
        
        guard let nextUrlString = next, let url = URL(string: nextUrlString) else { return }
        
        isLoadingMoreResults = true
    
        guard let request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.next = info.next // Capture new pagination url
                
                let additionalLocations = moreResults.compactMap({
                    return RMLocationTableViewCellViewModel(location: $0)
                })
                var newResults: [RMLocationTableViewCellViewModel] = []
                
                switch strongSelf.results {
                case .locations(let existingResults):
                    newResults = existingResults + additionalLocations
                    strongSelf.results = .locations(newResults)
                    break
                case .characters, .episode:
                    break
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    
                    // Notify via callback
                    comletion(newResults)
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreResults = false
            }
        }
    }
    
    public func fetchAdditionalResults(comletion: @escaping([any Hashable]) -> Void) {
        guard !isLoadingMoreResults else { return }
        
        guard let nextUrlString = next, let url = URL(string: nextUrlString) else { return }
        
        isLoadingMoreResults = true
    
        guard let request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        switch results {
        case .characters(let existingResults):
            RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // Capture new pagination url
                    
                    let additionalResults = moreResults.compactMap({
                        return RMCharacterCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
                    })
                    var newResults: [RMCharacterCollectionViewCellViewModel] = []
                    
                    newResults = existingResults + additionalResults
                    strongSelf.results = .characters(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify via callback
                        comletion(newResults)
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
                }
            }
        
        case .episode(let existingResults):
            RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // Capture new pagination url
                    
                    let additionalResults = moreResults.compactMap({
                        return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
                    })
                    var newResults: [RMCharacterEpisodeCollectionViewCellViewModel] = []
                    
                    newResults = existingResults + additionalResults
                    strongSelf.results = .episode(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify via callback
                        comletion(newResults)
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
                }
            }
        case .locations:
            // TableView case
            break
        }
        
        
    }
}

enum RMSearchResultType {
    case characters([RMCharacterCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    case episode([RMCharacterEpisodeCollectionViewCellViewModel])
}

//
//  RMAPICacheManader.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 10.04.2023.
//

import Foundation

/// MAnagers in memory session scoped API caches
final class RMAPICacheManader {
    
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    
    init() {
        setUpCache()
    }
    
    // MARK: - Public
    public func cacheResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return nil }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    private func setUpCache() {
        RMEndpoint.allCases.forEach({ endpint in
            cacheDictionary[endpint] = NSCache<NSString, NSData>()
            
        })
    }
}

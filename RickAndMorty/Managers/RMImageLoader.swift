//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 08.04.2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// Get image content with URL
    /// - Parameters:
    ///  - url: Source url
    ///  - completion: Callback
    public func dowloadImage(_ url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data)) // NSdata == Data | NSString == String
            return
        }
        
        let rquest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: rquest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
           
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}

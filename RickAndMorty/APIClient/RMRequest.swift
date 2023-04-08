//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 07.04.2023.
//

import Foundation

/// Object that represents a singlet API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endPoint: RMEndpoint
    
    ///  Path components for API, if any
    private let pathComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for API request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        return string
    }
    
    ///  Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http pethod
    public let httpMethod = "GET"
    
    // MARK: - Public
    /// construct endpoint
    /// - Parametrs:
    ///  - endpoint: Target endpoint
    ///  - pathComponents: Collection of Path components
    ///  - queryParameters: Collection of query parameters
    public init(endPoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndoint)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    static let listCharectersRequest = RMRequest(endPoint: .character)
}

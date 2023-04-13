//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 10.04.2023.
//

import UIKit

/// Configurable controller to search
final class RMSearchViewController: UIViewController {

    /// Configuration for search session
    struct Confog {
        enum `Type` {
            case charecter
            case episode
            case location
            
            var title: String {
                switch self {
                case .charecter:
                    return "Search Charecter"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        let type: `Type`
    }
    
    private let config: Confog
    
    // MARK: - Init
    
    init(config: Confog) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
    

}

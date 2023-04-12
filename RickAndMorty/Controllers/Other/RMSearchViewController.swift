//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 10.04.2023.
//

import UIKit

/// Configurable controller to search
final class RMSearchViewController: UIViewController {

    struct Confog {
        enum `Type` {
            case charecter
            case episode
            case location
        }
        let type: `Type`
    }
    
    private let config: Confog
    
    init(config: Confog) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    

}

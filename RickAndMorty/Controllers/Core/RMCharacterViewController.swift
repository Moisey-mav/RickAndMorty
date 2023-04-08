//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 06.04.2023.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let characterList = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }
    
    private func setUpView() {
        characterList.delegate = self
        view.addSubview(characterList)
        NSLayoutConstraint.activate([
            characterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - RMCharacterListViewDelegate
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        // Open detail controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

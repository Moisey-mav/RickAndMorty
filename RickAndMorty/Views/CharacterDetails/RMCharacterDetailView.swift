//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 08.04.2023.
//

import UIKit

/// View for single character info
final class RMCharacterDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let  viewModel: RMCharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else { return }
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionsIndex, _ in
            return self.createSection(for: sectionsIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdettifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdettifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdettifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }

    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionsType = viewModel.sections
        
        switch sectionsType[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        }
    }
}

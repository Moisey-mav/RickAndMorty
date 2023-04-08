//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Владислав Моисеев on 08.04.2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdettifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubviews(titleContainderView, valueLabel, iconImageView)
        titleContainderView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainderView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainderView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainderView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainderView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainderView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainderView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainderView.bottomAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainderView.topAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = nil
        titleLabel.textColor = nil
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayVlaue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}

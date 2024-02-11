//
//  BreedDetailView.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedDetailView: UIView {
    //MARK: - Properties
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = {
            UICollectionViewCompositionalLayout { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let numberOfItems = 2
                let size = (environment.container.effectiveContentSize.width - CGFloat(numberOfItems - 1)) / CGFloat(numberOfItems)
                let spacing: CGFloat = 1.0
                
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(size))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(spacing)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                
                return section
            }
        }()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BreedDetailCell.self, forCellWithReuseIdentifier: BreedDetailCell.reuseIdentifier)
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    let stateButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Life cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setups
    
    private func setUpUI() {
        addSubview(collectionView)
        addSubview(stateButton)
        addSubview(loadingIndicator)
        
        backgroundColor = .white
        
        stateButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func updateState(_ state: BreedDetailStatus) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            stateButton.isHidden = true
            collectionView.isHidden = false
        case .success:
            loadingIndicator.stopAnimating()
            stateButton.isHidden = true
            collectionView.isHidden = false
        case .noResult:
            loadingIndicator.stopAnimating()
            stateButton.isHidden = false
            stateButton.setTitle("No result found.\nTap to retry", for: .normal)
            collectionView.isHidden = true
        case .failure(let error):
            loadingIndicator.stopAnimating()
            stateButton.isHidden = false
            stateButton.setTitle("\(error.localizedDescription).\nTap to retry", for: .normal)
            collectionView.isHidden = true
        }
    }
}

//
//  BreedDetailCell.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedDetailCell: UICollectionViewCell {
    static let reuseIdentifier = "BreedDetailCell"
    
    private let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dogImageView)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil
    }
    
    private func setupUI() {
        dogImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dogImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dogImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dogImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(item: BreedDetailCellItem) {
        dogImageView.image = UIImage(named: "doggys")
    }
}

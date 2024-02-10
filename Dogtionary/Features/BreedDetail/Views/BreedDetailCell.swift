//
//  BreedDetailCell.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Kingfisher

final class BreedDetailCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let reuseIdentifier = "BreedDetailCell"
    
    private let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil
    }
    
    //MARK: - UI setups
    
    private func setupUI() {
        contentView.addSubview(dogImageView)
        
        dogImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dogImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dogImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dogImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(item: BreedDetailCellItem) {
        guard let url = URL(string: item.imageUrl) else { return }
        dogImageView.kf.indicatorType = .activity

        dogImageView.kf.setImage(
            with: url,
            options: [
                .processor(DownsamplingImageProcessor(size: frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ])
    }
}

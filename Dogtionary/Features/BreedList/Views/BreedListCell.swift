//
//  BreedListCell.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedListCell: UITableViewCell {
    //MARK: - Properties
    
    static let reuseIdentifier = "BreedListCell"
    
    private let breedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Life cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setup
    
    private func setupUI() {
        contentView.addSubview(breedNameLabel)
        
        accessoryType = .disclosureIndicator
        
        breedNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        breedNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        breedNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        breedNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    //MARK: - Configuration
    
    func configure(item: BreedListCellItem) {
        breedNameLabel.text = item.isSubBreed ? "  ► \(item.displayName)" : item.displayName
        breedNameLabel.textColor = item.isSubBreed ? .gray : .black
    }
}

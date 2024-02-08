//
//  BreedListCell.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedListCell: UITableViewCell {
    static let reuseIdentifier = "BreedListCell"
    
    private let breedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(breedNameLabel)
        
        accessoryType = .disclosureIndicator
        
        breedNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        breedNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        breedNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        breedNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func configure(item: BreedListCellItem) {
        breedNameLabel.text = item.breedName
    }
}

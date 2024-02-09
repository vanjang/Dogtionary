//
//  BreedListView.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedListView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 50
        tableView.register(BreedListCell.self, forCellReuseIdentifier: BreedListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        return view
    }()
    
    var stateButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        addSubview(stateButton)
        addSubview(loadingIndicator)
        backgroundColor = .white

        stateButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func updateState(_ state: BreedSearchState) {
        switch state {
        case .loading:
            stateButton.isHidden = true
            loadingIndicator.startAnimating()
        case .success:
            stateButton.isHidden = true
            loadingIndicator.stopAnimating()
        case .noResults:
            stateButton.isHidden = false
            stateButton.setTitle("No result found.\nTap to retry", for: .normal)
            loadingIndicator.stopAnimating()
        case .failure(let error):
            stateButton.isHidden = false
            stateButton.setTitle("\(error.localizedDescription).\nTap to retry", for: .normal)
            loadingIndicator.stopAnimating()
        }
    }
}

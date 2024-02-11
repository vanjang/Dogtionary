//
//  BreedListView.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedListView: UIView {
    //MARK: - Properties
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setups
    
    private func setupUI() {
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.BreedList.tableViewViewId
        
        addSubview(tableView)
        addSubview(stateButton)
        addSubview(loadingIndicator)
        backgroundColor = .white

        stateButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    //MARK: - Update UI
    
    func updateState(_ state: BreedListState) {
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

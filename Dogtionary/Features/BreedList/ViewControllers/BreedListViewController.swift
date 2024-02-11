//
//  BreedListViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 06/02/2024.
//

import UIKit
import Combine

final class BreedListViewController: UIViewController {
    //MARK: - Properties
    
    private var cancellables: [AnyCancellable] = []
    private let viewModel: BreedListViewModelType
    private let selection = PassthroughSubject<BreedListCellItem, Never>()
    private let search = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        if let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.accessibilityIdentifier = AccessibilityIdentifiers.BreedList.searchTextFieldId
        }
        return searchController
    }()
    
    private lazy var baseView: BreedListView = {
        self.view as? BreedListView ?? BreedListView()
    }()
    
    private var cellItems: [BreedListCellItem] = []
    
    //MARK: - Life cycles
    
    init(viewModel: BreedListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        notifyFetching()
        configure()
    }
    
    override func loadView() {
        super.loadView()
        self.view = BreedListView()
    }
    
    //MARK: - Binder & configurations
    
    private func bind(viewModel: BreedListViewModelType) {
        let input = BreedListViewModelInput(appear: appear.eraseToAnyPublisher(),
                                            search: search.eraseToAnyPublisher(),
                                            selection: selection.eraseToAnyPublisher())
        
        let output = viewModel.connect(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.updateCellItemsBy(state)
            self.baseView.updateState(state)
        }).store(in: &cancellables)
    }
    
    @objc func notifyFetching() {
        appear.send(())
    }
    
    private func updateCellItemsBy(_ state: BreedListState) {
        switch state {
        case .success(let items): cellItems = items
        default: cellItems = []
        }
        baseView.tableView.reloadData()
    }
    
    private func configure() {
        // nav bar setup
        title = "Dogtionary"
        navigationItem.searchController = self.searchController
        
        // searchVC setup
        searchController.isActive = true
        
        // view setup
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self//dataSource
        baseView.stateButton.addTarget(self, action: #selector(notifyFetching), for: .touchUpInside)
    }
    
    deinit {
        print("BreedListViewController is deinitialised")
    }
}

extension BreedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        // notify cell press
        selection.send(cellItems[indexPath.row])
    }
}

extension BreedListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search.send(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.send("")
    }
}

extension BreedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedListCell.reuseIdentifier, for: indexPath) as? BreedListCell else { return UITableViewCell() }
        cell.configure(item: cellItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellItems.count
    }
}

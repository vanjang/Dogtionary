//
//  BreedListViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 06/02/2024.
//

import UIKit
import Combine

class BreedListViewController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private let viewModel: BreedListViewModelType
    private let selection = PassthroughSubject<String, Never>()
    private let search = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var baseView: BreedListView = {
        self.view as? BreedListView ?? BreedListView()
    }()
    
    private lazy var dataSource = makeDataSource()
    
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
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notifyFetching()
    }

    override func loadView() {
        super.loadView()
        self.view = BreedListView()
    }
    
    private func bind(viewModel: BreedListViewModelType) {
        let input = BreedSearchViewModelInput(appear: appear.eraseToAnyPublisher(),
                                               search: search.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())

        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.updateDataSourceBy(state)
            self.baseView.updateState(state)
        }).store(in: &cancellables)
        

    }
    
    private func updateDataSourceBy(_ state: BreedSearchState) {
        switch state {
        case .success(let items): update(with: items)
        default: update(with: [])
        }
    }
    
    private func configure() {
        // nav bar setup
        title = "Dogtionary"
        navigationItem.searchController = self.searchController
        
        // searchVC setup
        searchController.isActive = true
        
        // view setup
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = dataSource
        baseView.stateButton.addTarget(self, action: #selector(notifyFetching), for: .touchUpInside)
    }
    
    @objc func notifyFetching() {
        appear.send(())
    }
    
    deinit {
        print("BreedListViewController is deinitialised")
    }
    
}

extension BreedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let snapshot = dataSource.snapshot()
        guard snapshot.itemIdentifiers.indices.contains(indexPath.row) else { return }
        selection.send(snapshot.itemIdentifiers[indexPath.row].breedName)
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

fileprivate extension BreedListViewController {
    enum Section: CaseIterable {
        case breed
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, BreedListCellItem> {
        return UITableViewDiffableDataSource(
            tableView: baseView.tableView,
            cellProvider: {  tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedListCell.reuseIdentifier) as? BreedListCell else {
                    assertionFailure("Failed to dequeue \(BreedListCell.self)!")
                    return UITableViewCell()
                }
                cell.configure(item: item)
                return cell
            }
        )
    }
    
    func update(with breed: [BreedListCellItem], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, BreedListCellItem>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(breed, toSection: .breed)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

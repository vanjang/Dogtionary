//
//  BreedListViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 06/02/2024.
//

import UIKit

class BreedListViewController: UIViewController {    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // temp data
        let temp: [BreedListCellItem] = [BreedListCellItem(breedName: "!", hasSubBreeds: false, isSubBreed: false, isExpanded: false),
                                         BreedListCellItem(breedName: "2", hasSubBreeds: false, isSubBreed: false, isExpanded: false),
                                         BreedListCellItem(breedName: "3", hasSubBreeds: false, isSubBreed: false, isExpanded: false)]
        update(with: temp)
        configure()
    }
    
    override func loadView() {
        super.loadView()
        self.view = BreedListView()
    }
    
    private func configure() {
        navigationItem.searchController = self.searchController
        searchController.isActive = true
        
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = dataSource
        
        title = "Dogtionary"
    }
    
}

extension BreedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(BreedDetailViewController(), animated: true)
    }
}

extension BreedListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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

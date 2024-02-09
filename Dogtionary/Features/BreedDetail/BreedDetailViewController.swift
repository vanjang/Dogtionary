//
//  BreedDetailViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Combine

final class BreedDetailViewController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private let viewModel: BreedDetailViewModelType
    private let selection = PassthroughSubject<UIImage, Never>()
    
    private lazy var baseView: BreedDetailView = {
        self.view as? BreedDetailView ?? BreedDetailView()
    }()
    
    private lazy var dataSource = makeDataSource()
    
    init(viewModel: BreedDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind(to: viewModel)
    }
    
    override func loadView() {
        super.loadView()
        self.view = BreedDetailView()
    }
    
    private func bind(to viewModel: BreedDetailViewModelType) {
        let output = viewModel.transform(input: selection.eraseToAnyPublisher())
        
        output.sink { [unowned self] items in
            self.update(with: items)
        }
        .store(in: &cancellables)
    }
    
    private func configure() {
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = dataSource
    }
    
    deinit {
        print("BreedDetailViewController is deinitialised")
    }
}

extension BreedDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        guard snapshot.itemIdentifiers.indices.contains(indexPath.row) else { return }
        selection.send(snapshot.itemIdentifiers[indexPath.row].image)
    }
}

fileprivate extension BreedDetailViewController {
    enum Section: CaseIterable {
        case breedDetail
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, BreedDetailCellItem> {
       UICollectionViewDiffableDataSource(
            collectionView: baseView.collectionView,
            cellProvider: {  collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedDetailCell.reuseIdentifier, for: indexPath) as? BreedDetailCell else {
                    assertionFailure("Failed to dequeue \(BreedDetailCell.self)!")
                    return UICollectionViewCell()
                }
                cell.configure(item: item)
                return cell
            }
        )
    }

    func update(with breed: [BreedDetailCellItem], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, BreedDetailCellItem>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(breed, toSection: .breedDetail)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

//
//  BreedDetailViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Combine

final class BreedDetailViewController: UIViewController {
    //MARK: - Properties
    
    private var cancellables: [AnyCancellable] = []
    private let viewModel: BreedDetailViewModelType
    private let selection = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    
    private lazy var baseView: BreedDetailView = {
        self.view as? BreedDetailView ?? BreedDetailView()
    }()
    
    private lazy var dataSource = makeDataSource()
    
    //MARK: - Life cycles
    
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
        notifyFetching()
    }
    
    override func loadView() {
        super.loadView()
        self.view = BreedDetailView()
    }
    
    //MARK: - Binder and configuratinos
    
    private func bind(to viewModel: BreedDetailViewModelType) {
        let output = viewModel.connect(input: BreedDetailViewModelInput(appear: appear.eraseToAnyPublisher(),
                                                                          selection: selection.eraseToAnyPublisher()))
        
        output.breedName
            .sink { [weak self] title in
                self?.title = title
            }.store(in: &cancellables)
        
        output
            .status
            .sink { [unowned self] state in
                switch state {
                case .success(let items): self.update(with: items)
                default: break
                }
                self.baseView.updateState(state)
            }
            .store(in: &cancellables)
    }
    
    @objc func notifyFetching() {
        appear.send(())
    }
    
    private func configure() {
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = dataSource
        baseView.stateButton.addTarget(self, action: #selector(notifyFetching), for: .touchUpInside)
    }
    
    deinit {
        print("BreedDetailViewController is deinitialised")
    }
}

extension BreedDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        guard snapshot.itemIdentifiers.indices.contains(indexPath.row) else { return }
        selection.send(snapshot.itemIdentifiers[indexPath.row].imageUrl)
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

//
//  BreedDetailViewController.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

final class BreedDetailViewController: UIViewController {
    private lazy var baseView: BreedDetailView = {
        self.view as? BreedDetailView ?? BreedDetailView()
    }()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        // temp data
        let temp: [BreedDetailCellItem] = [
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem(),
            BreedDetailCellItem()
        ]
        update(with: temp)
    }
    
    override func loadView() {
        super.loadView()
        self.view = BreedDetailView()
    }
    
    private func configure() {
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = dataSource
    }
}

extension BreedDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
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

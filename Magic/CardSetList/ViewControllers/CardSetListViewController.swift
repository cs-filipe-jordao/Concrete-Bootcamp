//
//  CardSetListViewController.swift
//  Magic
//
//  Created by filipe.n.jordao on 09/05/19.
//

import Nuke
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class CardSetListViewController: UIViewController {
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellViewModel>>
    private let cardSetView = CardSetListView()
    private let sectionsRelay = BehaviorRelay<[SectionModel<String, CellViewModel>]>(value: [])
    private let disposeBag = DisposeBag()
    private let viewModel: CardSetListViewModel

    init(viewModel: CardSetListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        registerCells()

        setupLoading()
        setupRelay()
        setupDelegate()
        setupDataSource()

        viewModel.bindDidLoad(didLoadDriver())
        viewModel.bindEndOfPage(didReachBottom())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func registerCells() {
        cardSetView.collection.register(CollectionViewSectionHeader.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: "SectionHeader")

        cardSetView.collection.register(CardCell.self, forCellWithReuseIdentifier: "MagicCardCell")
        cardSetView.collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
    }

    func setupDelegate() {
        cardSetView.collection.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    func setupRelay() {
        let sections = self.sections()
        sections.drive(sectionsRelay)
            .disposed(by: disposeBag)
    }

    func setupDataSource() {
        let sections = sectionsRelay.asDriver()
        sections.drive(cardSetView.collection.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }

    func setupLoading() {
        viewModel.state
            .drive(onNext: { [weak self] state in
                guard let self = self else { return }
                self.cardSetView.activityIndicator.isHidden = state != .loading && state != .loadingPage
            })
            .disposed(by: disposeBag)
    }

    func sections() -> Driver<[SectionModel<String, CellViewModel>]> {
        return viewModel.state
            .map { state -> [CollectionViewSectionViewModel]? in
                if case let .loaded(sections) = state {
                    return sections
                }
                return nil
            }
            .filter { $0 != nil }
            .map { $0! }
            .map { sections  in sections.map { SectionModel(model: $0.title, items: $0.cells) }}
    }

    func dataSource() -> DataSource {
        let dataSource = DataSource(configureCell: { _, collection, indexPath, item in
            let cell =  collection.dequeueReusableCell(withReuseIdentifier: item.cellId, for: indexPath)

            if let typeCell = cell as? TextCell,
                let item = item as? TextCellViewModel {
                    typeCell.typeLabel.text = item.type
            }

            if let cardCell = cell as? CardCell,
                let item = item as? CardViewModel {
                cardCell.loadImage(url: item.imageURL)
            }

            return cell
        })

        dataSource.configureSupplementaryView = { dataSource, collection, kind, index in
            guard let section = collection.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: "SectionHeader",
                                                                            for: index) as? CollectionViewSectionHeader
                else { return UICollectionReusableView() }

            section.title.text = dataSource[index.section].model
            return section
        }

        return dataSource
    }

    func didLoadDriver() -> Driver<Void> {
        return rx.sentMessage(#selector(viewDidLoad))
            .map {_ in Void() }
            .asDriver(onErrorDriveWith: .empty())
    }

    func didReachBottom() -> Driver<Void> {
        return cardSetView.collection
            .isNearBottom()
            .filter { $0 == true }
            .map { _ in Void() }
    }
}

extension CardSetListViewController {
    override func loadView() {
        view  = cardSetView
    }
}

extension CardSetListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sections = sectionsRelay.value
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        let collectionWidth = collectionView.frame.width
        switch item {
        case is CardViewModel:
            let width = (collectionWidth - 40)/3
            let height = width * 1.38
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: collectionWidth, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}

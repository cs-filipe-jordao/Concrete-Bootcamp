//
//  CardSetListViewController.swift
//  Magic
//
//  Created by filipe.n.jordao on 09/05/19.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class CardSetListViewController: UIViewController {
    private let cardSetView = CardSetListView()
    private let relay = BehaviorRelay<[SectionModel<String, CellViewModel>]>(value: [])
    private let disposeBag = DisposeBag()
    private let viewModel: CardSetListViewModel

    init(viewModel: CardSetListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        registerCells()

        cardSetView.collection.rx.setDelegate(self)
            .disposed(by: disposeBag)

        let sections = self.sections()

        sections.drive(relay)
            .disposed(by: disposeBag)
        sections.drive(cardSetView.collection.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)

        viewModel.bindDidLoad(didLoadDriver())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func registerCells() {
        cardSetView.collection.register(CardCell.self, forCellWithReuseIdentifier: "MagicCardCell")
        cardSetView.collection.register(TypeCell.self, forCellWithReuseIdentifier: "TextCell")
    }

    func sections() -> Driver<[SectionModel<String, CellViewModel>]> {
        return viewModel.state
            .debug("state")
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

    func dataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellViewModel>> {
        return .init(configureCell: { _, collection, indexPath, item in

            let cell =  collection.dequeueReusableCell(withReuseIdentifier: item.cellId, for: indexPath)

            if let typeCell = cell as? TypeCell,
                let item = item as? TextCellViewModel {
                    typeCell.typeLabel.text = item.type
            }
            if let cardCell = cell as? CardCell {
                cardCell.banner.image = #imageLiteral(resourceName: "cardback")
            }

            return cell
        })
    }

    func didLoadDriver() -> Driver<Void> {
        return rx.sentMessage(#selector(viewDidLoad))
            .map {_ in Void() }
            .asDriver(onErrorDriveWith: .empty())
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
        let sections = relay.value
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        let collectionWidth = collectionView.frame.width
        switch item {
        case is CardViewModel:
            let width = (collectionWidth/3) - 10
            let height = width * 1.38
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: collectionWidth, height: 40)
        }
    }
}

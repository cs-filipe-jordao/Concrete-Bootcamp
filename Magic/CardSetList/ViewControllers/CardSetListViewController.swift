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
    let cardSetView = CardSetListView()
    let relay = BehaviorRelay<[SectionModel<String, CellViewModel>]>(value: [])

    private let disposeBag = DisposeBag()
}

extension CardSetListViewController {
    override func loadView() {
        view  = cardSetView
    }

    override func viewDidLoad() {

        let section: SectionModel<String, CellViewModel> = SectionModel(model: "",
                                                                        items: [ TextCellViewModel(type: "algumaCoisa"),
                                                                                 CardViewModel(imageURL: nil)])

        let obs = Driver.just([section])
        obs.drive(relay)

        cardSetView.collection.register(CardCell.self, forCellWithReuseIdentifier: "MagicCardCell")
        cardSetView.collection.register(TypeCell.self, forCellWithReuseIdentifier: "TextCell")

        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, CellViewModel>>(
            configureCell: { _, collection, indexPath, item in

                let cell =  collection.dequeueReusableCell(withReuseIdentifier: item.cellId, for: indexPath)
                cell.backgroundColor = .red

                if let typeCell = cell as? TypeCell {
                    typeCell.typeLabel.text = "asdasdasdasdasdasda"
                }
                if let cardCell = cell as? CardCell {
                    cardCell.banner.image = #imageLiteral(resourceName: "CardTestAsset")
                }

                return cell
        })

        cardSetView.collection.rx.setDelegate(self).disposed(by: disposeBag)
        obs.drive(cardSetView.collection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CardSetListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
            return CGSize(width: collectionWidth, height: 70)
        }
    }
}

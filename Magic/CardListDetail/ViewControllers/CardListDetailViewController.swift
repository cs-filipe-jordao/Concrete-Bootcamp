//
//  CardListDetailView.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import UIKit
import RxCocoa
import RxSwift
import Nuke

class CardListDetailViewController: UIViewController {
    let cardListView = CardListDetailView()

    let viewModel: CardListDetailViewModel?

    private let disposeBag = DisposeBag()
    init(viewModel: CardListDetailViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel?.bindDidLoad(didLoadDriver())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didLoadDriver() -> Driver<Void> {
        return rx.sentMessage(#selector(viewDidLoad))
            .map {_ in Void() }
            .asDriver(onErrorDriveWith: .empty())
    }
}

extension CardListDetailViewController {
    override func loadView() {
        view = cardListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setItemSize()
        cardListView.collection.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        viewModel?.state
            .map { (state) -> [CardDetailViewModel]? in
                if case let .loaded(cards) = state {
                    return cards
                }

                return nil
            }
            .filter { $0 != nil }
            .map { $0! }
            .drive(cardListView.collection.rx.items(cellIdentifier: "CardCell",
                                                    cellType: CardCell.self)
            ) { index, model, cell in
                cell.banner.image = #imageLiteral(resourceName: "CardTestAsset")
            }
            .disposed(by: disposeBag)
    }

    func setItemSize() {
        let collectionWidth = 400.0
        let width = collectionWidth * 0.75
        let height = width * 1.38
        let size = CGSize(width: width, height: height)
        cardListView.setItemSize(size)
    }
}

//
//  CardSetListViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 09/05/19.
//

import Foundation
import RxSwift
import RxCocoa

class CardSetListViewModel {
    public let state: Driver<State>

    enum State: Equatable {
        case initial
        case loading
        case loadingPage
        case loaded([CollectionViewSectionViewModel])
        case error(String)
    }

    private let privateState = BehaviorRelay(value: State.initial)
    private let nextPage = BehaviorRelay(value: 0)
    private let disposeBag: DisposeBag
    private let dataSource: MagicCardSetProvider
    private let groupingStrategy: CardGroupingStrategy

    init(dataSource: MagicCardSetProvider, groupingStrategy: CardGroupingStrategy) {
        state = privateState.asDriver()
        disposeBag = DisposeBag()
        self.dataSource = dataSource
        self.groupingStrategy = groupingStrategy
    }

    func bindDidLoad(_ observable: Driver<Void>) {
        observable
            .map { State.loading }
            .drive(privateState)
            .disposed(by: disposeBag)

        observable
            .map { 0 }
            .asObservable()
            .flatMap(dataSource.fetch)
            .map(self.section)
            .map { State.loaded([$0]) }
            .asDriver(onErrorJustReturn: .error("Something wrong happened"))
            .drive(onNext: { [weak self] state in
                guard let self = self else { return }
                self.privateState.accept(state)
                self.nextPage.accept(1)
            })
            .disposed(by: disposeBag)
    }

    func section(from cardSet: MagicCardSet) -> CollectionViewSectionViewModel {
        let groupedCards = groupingStrategy.group(cards: cardSet.cards)

        let cellsViewModels = groupedCards.flatMap { (group) -> [CellViewModel] in
            let cards = group.value.map { CardViewModel(imageURL: $0.imageURL) }

            return [TextCellViewModel(type: group.key)] + cards
        }

        return CollectionViewSectionViewModel(title: cardSet.name,
                                              cells: cellsViewModels)
    }
}

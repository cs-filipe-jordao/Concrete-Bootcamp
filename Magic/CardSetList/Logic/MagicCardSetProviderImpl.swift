//
//  MagicCardSetProviderImpl.swift
//  Magic
//
//  Created by filipe.n.jordao on 08/05/19.
//

import Foundation
import RxSwift

class MagicCardSetProviderImpl {
    let cardService: CardService
    let cardSetService: CardSetService
    let groupingStrategy: CardGroupingStrategy

    init(cardService: CardService, cardSetService: CardSetService, groupingStrategy: CardGroupingStrategy) {
        self.cardService = cardService
        self.cardSetService = cardSetService
        self.groupingStrategy = groupingStrategy
    }
}

extension MagicCardSetProviderImpl: MagicCardSetProvider {
    func fetch(page: Int) -> Single<MagicCardSet> {
        let setObservable = cardSetService.fetchSets()
            .map { $0[page] }

        let cardsObservable = setObservable.flatMap(cardService.fetchAllCards)
            .map { $0.map(MagicCard.init) }
            .map(groupingStrategy.group)

        return Single<MagicCardSet>.zip(setObservable, cardsObservable, resultSelector: MagicCardSet.init)
    }
}

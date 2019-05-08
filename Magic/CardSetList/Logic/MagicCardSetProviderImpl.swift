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

    init(cardService: CardService, cardSetService: CardSetService) {
        self.cardService = cardService
        self.cardSetService = cardSetService
    }
}

extension MagicCardSetProviderImpl: MagicCardSetProvider {
    func fetch(page: Int) -> Single<(set: MagicCardSet, cards: [MagicCard])> {
        let setObservable = cardSetService.fetchSets()
            .map { $0[page] }

        let cardsObservable = setObservable.flatMap(cardService.fetchAllCards)
            .map { $0.map(MagicCard.init) }

        let magicSetObservable = setObservable.map(MagicCardSet.init)

        return .zip(magicSetObservable,
                    cardsObservable,
                    resultSelector: { (set: $0, cards: $1) })
    }
}

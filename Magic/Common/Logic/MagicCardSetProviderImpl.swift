//
//  MagicCardSetProviderImpl.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

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
    func fetchSet(number: Int, completion: @escaping (Result<MagicCardSet, Error>) -> Void) {
        let group = DispatchGroup()
        var anyError: Error?
        var set: MagicCardSet?

        group.enter()
        cardSetService.fetchSets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                anyError = anyError ?? error
            case let .success(sets):
                group.enter()
                self.cardService.fetchAllCards(from: sets[number], completion: { [weak self] result in

                    guard let self = self else { return }
                    switch result {
                    case let .failure(error):
                        anyError = anyError ?? error
                    case let .success(cards):
                        let magicCards = cards.map(MagicCard.init)
                        let groupedCards = self.groupingStrategy.group(cards: magicCards)
                        set = MagicCardSet(set: sets[number], cards: groupedCards)
                        group.leave()
                    }
                })
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = anyError {
                completion(.failure(error))
            }

            guard let set = set else { return }
            completion(.success(set))
        }
    }
}

//
//  TypeCardGroupingStrategy.swift
//  Magic
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Foundation

class TypeCardGroupingStrategy: CardGroupingStrategy {
    typealias GroupKey = String
    typealias Grouped = [GroupKey: [Card]]

    func group(cards: [Card]) -> [GroupKey: [Card]] {
        let keyValues = cards.flatMap(groups)

        return Grouped(keyValues, uniquingKeysWith: +)
    }

    private func groups(from card: Card) -> [GroupKey: [Card]] {
        let keyValues = card.types.map { ($0, [card])}

        return Grouped(keyValues, uniquingKeysWith: +)
    }
}

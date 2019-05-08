//
//  TypeCardGroupingStrategy.swift
//  Magic
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Foundation

class TypeCardGroupingStrategy: CardGroupingStrategy {
    typealias GroupKey = String
    typealias Grouped = [GroupKey: [MagicCard]]

    func group(cards: [MagicCard]) -> [GroupKey: [MagicCard]] {
        let keyValues = cards.flatMap(groups)

        return Grouped(keyValues, uniquingKeysWith: +)
    }

    private func groups(from card: MagicCard) -> [GroupKey: [MagicCard]] {
        let keyValues = card.types.map { ($0, [card])}

        return Grouped(keyValues, uniquingKeysWith: +)
    }
}

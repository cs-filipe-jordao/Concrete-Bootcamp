//
//  MagicCardSet.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

struct MagicCardSet {
    public let code: String
    public let name: String
    public let releaseDate: Date
    public let cards: [String: [MagicCard]]
}

extension MagicCardSet {
    init?(set: CardSet, cards: [String: [MagicCard]]) {
        code = set.code
        name = set.name

        guard let date = Date.date(from: set.releaseDate) else { return nil }
        releaseDate = date

        self.cards = cards
    }
}

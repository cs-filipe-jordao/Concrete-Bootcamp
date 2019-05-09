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
    public let releaseDate: Date?
    public let cards: [MagicCard]
}

extension MagicCardSet {
    init (set: CardSet, cards: [MagicCard]) {
        code = set.code
        name = set.name
        releaseDate = Date.date(from: set.releaseDate)
        self.cards = cards
    }
}

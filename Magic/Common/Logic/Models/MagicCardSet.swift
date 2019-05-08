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
}

extension MagicCardSet {
    init (set: CardSet) {
        code = set.code
        name = set.name
        releaseDate = Date.date(from: set.releaseDate)
    }
}

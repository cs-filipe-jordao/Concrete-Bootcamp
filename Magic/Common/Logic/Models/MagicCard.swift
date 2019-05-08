//
//  MagicCard.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

struct MagicCard: Hashable {
    public let name: String
    public let type: String
    public let types: [String]
    public let cardSet: String
    public let imageURL: URL?
    public let identifier: String
}

extension MagicCard {
    init(card: Card) {
        name = card.name
        type = card.type
        types = card.types
        cardSet = card.cardSet
        imageURL = card.imageURL.flatMap(URL.init)
        identifier = card.identifier
    }
}

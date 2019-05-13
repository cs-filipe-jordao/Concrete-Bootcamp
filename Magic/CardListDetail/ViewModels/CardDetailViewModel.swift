//
//  CardDetailViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation

class CardDetailViewModel: CardViewModel {
    let isFavorite: Bool

    override init(imageURL: URL?) {
        isFavorite = false
        super.init(imageURL: imageURL)
    }

    init(imageURL: URL?, isFavorite: Bool) {
        self.isFavorite = isFavorite
        super.init(imageURL: imageURL)
    }
}

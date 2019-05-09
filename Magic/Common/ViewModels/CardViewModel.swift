//
//  CardViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

class CardViewModel: CellViewModel {
    let cellId = "MagicCardCell"

    let imageURL: URL?

    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
}

extension CardViewModel: Equatable {
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.imageURL == rhs.imageURL
    }
}

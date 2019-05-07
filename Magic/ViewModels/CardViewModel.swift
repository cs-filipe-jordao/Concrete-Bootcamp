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
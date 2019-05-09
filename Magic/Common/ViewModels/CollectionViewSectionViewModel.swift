//
//  CardSetViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

class CollectionViewSectionViewModel {
    let title: String
    let cells: [CellViewModel]

    init(title: String, cells: [CellViewModel]) {
        self.title = title
        self.cells = cells
    }
}

extension CollectionViewSectionViewModel: Equatable {
    static func == (lhs: CollectionViewSectionViewModel, rhs: CollectionViewSectionViewModel) -> Bool {
        let lhsCells = lhs.cells.map(CellViewModelEquatable.init)
        let rhsCells = rhs.cells.map(CellViewModelEquatable.init)

        return lhs.title == rhs.title
            && lhsCells == rhsCells
    }
}

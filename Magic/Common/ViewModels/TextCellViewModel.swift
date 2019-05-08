//
//  TypeViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

class TextCellViewModel: CellViewModel {
    let cellId = "TextCell"

    let type: String

    init(type: String) {
        self.type = type
    }
}

//
//  TypeViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

class TypeViewModel: CellViewModel {
    let cellId = "TypeHeaderCell"

    let type: String

    init(type: String) {
        self.type = type
    }
}

//
//  ViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 06/05/19.
//

import Foundation

protocol CellViewModel {
    var cellId: String { get }
    func isEqualTo(_ other: CellViewModel) -> Bool
    func asEquatable() -> CellViewModelEquatable
}

extension CellViewModel where Self: Equatable {
    func isEqualTo(_ other: CellViewModel) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
    func asEquatable() -> CellViewModelEquatable {
        return CellViewModelEquatable(self)
    }
}

struct CellViewModelEquatable: CellViewModel, Equatable {
    var cellId: String { return value.cellId }

    init(_ value: CellViewModel) { self.value = value }
    private let value: CellViewModel

    static func == (lhs: CellViewModelEquatable, rhs: CellViewModelEquatable) -> Bool {
        return lhs.value.isEqualTo(rhs.value)
    }
}

//
//  CardSetListViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation
import RxSwift
import RxCocoa

enum State: Equatable {
    case initial
    case loading
    case loadingPage
    case loaded([CollectionViewSectionViewModel])
    case error(String)
}

protocol CardSetListViewModel {
    var state: Driver<State> { get }
    func bindDidLoad(_ observable: Driver<Void>)
    func bindEndOfPage(_ observable: Driver<Void>)
}

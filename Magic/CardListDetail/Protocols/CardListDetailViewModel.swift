//
//  CardListDetailViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation
import RxSwift
import RxCocoa

enum CardListDetailState {
    case initial
    case loaded([CardViewModel])
}

protocol CardListDetailViewModel {
    var state: Driver<CardListDetailState> { get }

    func bindDidLoad(_ observable: Driver<Void>)
}

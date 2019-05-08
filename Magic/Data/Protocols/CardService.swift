//
//  CardService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation
import RxSwift

protocol CardService {
    func fetchCards(from set: CardSet, page: Int) -> Single<[Card]>
    func fetchAllCards(from set: CardSet) -> Single<[Card]>
}

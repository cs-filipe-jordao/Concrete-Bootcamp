//
//  CardService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

protocol CardService {
    typealias CardsCompletion = (Result<[Card], Error>) -> Void
    func fetchCards(from set: CardSet, page: Int, completion: @escaping CardsCompletion)
    func fetchAllCards(from set: CardSet, completion: @escaping CardsCompletion)
}

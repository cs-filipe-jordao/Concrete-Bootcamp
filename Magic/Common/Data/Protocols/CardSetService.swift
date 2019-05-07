//
//  CardSetService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

public protocol CardSetService {
    typealias SetsCompletion = (Result<[CardSet], Error>) -> Void
    func fetchSets(completion: @escaping SetsCompletion)
}

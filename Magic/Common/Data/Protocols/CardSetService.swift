//
//  CardSetService.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation
import RxSwift

public protocol CardSetService {
    func fetchSets() -> Single<[CardSet]>
}

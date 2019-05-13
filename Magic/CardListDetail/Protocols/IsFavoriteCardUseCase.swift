//
//  IsFavoriteCardUseCase.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation
import RxSwift

protocol IsFavoriteCardUseCase {
    func favorites(from cards: [MagicCard]) -> Single<[(card: MagicCard, isfavorite: Bool)]>
}

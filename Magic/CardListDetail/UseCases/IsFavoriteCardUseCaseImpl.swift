//
//  IsFavoriteCardUseCaseImpl.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation
import RxSwift

class IsFavoriteCardUseCaseImpl: IsFavoriteCardUseCase {
    func favorites(from cards: [MagicCard]) -> Single<[(card: MagicCard, isfavorite: Bool)]> {
        return .just(cards.map { ($0, false) })
    }
}

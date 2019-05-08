//
//  CachedCartSetService.swift
//  Magic
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation
import RxSwift

public class CachedCardSetService: CardSetService {
    let cacheKey = "CARDSETS"
    let cache: Cache<[CardSet]>
    let service: CardSetService

    private let disposeBag = DisposeBag()

    public init(service: CardSetService, cache: Cache<[CardSet]> = Cache()) {
        self.service = service
        self.cache = cache
    }

    public func fetchSets() -> Single<[CardSet]> {
        if let sets = cache.object(for: cacheKey) {
            return .just(sets)
        } else {
            let sets = service.fetchSets()
            sets.subscribe(onSuccess: { [weak self] sets in
                guard let self = self else { return }

                self.cache.setObject(sets,
                                     for: self.cacheKey,
                                     timeout: 100000)
            })
            .disposed(by: disposeBag)

            return sets
        }
    }
}

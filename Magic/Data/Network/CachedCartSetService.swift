//
//  CachedCartSetService.swift
//  Magic
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

public class CachedCardSetService: CardSetService {
    let cacheKey = "CARDSETS"
    let cache: Cache<[CardSet]>
    let service: CardSetService

    public init(service: CardSetService, cache: Cache<[CardSet]> = Cache()) {
        self.service = service
        self.cache = cache
    }

    public func fetchSets(completion: @escaping SetsCompletion) {
        if let sets = cache.object(for: cacheKey) {
            completion(.success(sets))
        } else {
            service.fetchSets { [weak self] result in
                guard
                    let self = self,
                    case let .success(sets) = result else { return }

                self.cache.setObject(sets,
                                     for: self.cacheKey,
                                     timeout: 100000)
                completion(result)
            }
        }
    }
}

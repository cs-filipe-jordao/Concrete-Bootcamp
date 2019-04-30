//
//  CachedCartSetService.swift
//  Magic
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

public class CachedCardSetService: CardSetService {
    private let cacheKey = "CARDSETS"
    private let cache: Cache<[CardSet]>
    private let service: CardSetService

    public init(service: CardSetService) {
        self.service = service
        cache = Cache()
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

            }
        }
    }
}

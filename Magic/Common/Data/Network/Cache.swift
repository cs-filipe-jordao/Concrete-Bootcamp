//
//  Cache.swift
//  Magic
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

public class Cache<T> {
    class CacheEntry<T> {
        let value: T
        let expirationDate: Date
        let dateGenerator: () -> Date

        init(value: T, timeout: TimeInterval, dateGenerator: @escaping () -> Date) {
            self.value = value
            self.dateGenerator = dateGenerator
            expirationDate = dateGenerator().addingTimeInterval(timeout)
        }

        func isExpired() -> Bool {
            return dateGenerator() >= expirationDate
        }
    }

    private let cache: NSCache<NSString, CacheEntry<T>>
    private let dateGenerator: () -> Date

    public init(dateGenerator: @escaping () -> Date = Date.init) {
        cache = NSCache()
        self.dateGenerator = dateGenerator
    }

    public func object(for key: String) -> T? {
        guard let entry = cache.object(forKey: key as NSString), !entry.isExpired() else {
            cache.removeObject(forKey: key as NSString)

            return nil
        }

        return entry.value
    }

    public func setObject(_ object: T, for key: String, timeout: TimeInterval) {
        let entry = CacheEntry(value: object, timeout: timeout, dateGenerator: dateGenerator)
        cache.setObject(entry, forKey: key as NSString)
    }
}

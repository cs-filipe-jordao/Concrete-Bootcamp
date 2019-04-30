//
//  Cache.swift
//  Magic
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

class Cache<T> {
    private class Wrapper<T> {
        let value: T
        let expirationDate: Date

        var isExpired: Bool {
            return Date() < expirationDate
        }

        init(value: T, timeout: TimeInterval) {
            self.value = value
            expirationDate = Date().addingTimeInterval(timeout)
        }
    }

    private let cache: NSCache<NSString, Wrapper<T>>

    init() {
        cache = NSCache()
    }

    func object(for key: String) -> T? {
        guard let entry = cache.object(forKey: key as NSString), !entry.isExpired else {
            cache.removeObject(forKey: key as NSString)

            return nil
        }

        return entry.value
    }

    func setObject(_ object: T, for key: String, timeout: TimeInterval) {
        let entry = Wrapper(value: object, timeout: timeout)
        cache.setObject(entry, forKey: key as NSString)
    }
}

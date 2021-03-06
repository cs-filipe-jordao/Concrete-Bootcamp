//
//  CachedCardSetServiceSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Quick
import Nimble
import RxSwift

@testable import Magic

class CachedCardSetServiceSpec: QuickSpec {
    class MockedCache<T>: Cache<T> {
        var values = [String: T]()

        override func object(for key: String) -> T? {
            return values[key]
        }

        override func setObject(_ object: T, for key: String, timeout: TimeInterval) {
            values[key] = object
        }
    }

    class MockedCardSetService: CardSetService {
        let cardSet: CardSet
        var didCallFetch = false

        init(cardSet: CardSet) {
            self.cardSet = cardSet
        }

        func fetchSets() -> Single<[CardSet]> {
            didCallFetch = true

            return .just([cardSet])
        }
    }

    override func spec() {
        describe("A CachedCardSetService") {
            var mockedService: MockedCardSetService!
            var mockedCache: MockedCache<[CardSet]>!
            var sut: CachedCardSetService!
            let cardSet = CardSet(code: "15A", name: "A nice Set", releaseDate: "2007-03-03")

            beforeEach {
                mockedService = MockedCardSetService(cardSet: cardSet)
                mockedCache = MockedCache()
                sut = CachedCardSetService(service: mockedService, cache: mockedCache)
            }

            context("When Sets are fetched") {
                context("And there isnt a cached value") {
                    var result: [CardSet]?

                    beforeEach {
                        result = try? sut.fetchSets().toBlocking().first()
                    }

                    it("Should cache the retrieved value") {
                        expect(mockedCache.object(for: sut.cacheKey)).to(equal([cardSet]))
                    }

                    it("Should complete with the retrieved value") {
                        expect(result).toEventually(equal([cardSet]))
                    }
                }
            }

            context("And there is a cached value") {
                var result: [CardSet]?

                beforeEach {
                    mockedCache.values[sut.cacheKey] = [cardSet]
                    result = try? sut.fetchSets().toBlocking().single()
                }

                it("Shouldnt call fetch") {
                    expect(mockedService.didCallFetch).to(beFalse())
                }

                it("Should complete with the cached value") {
                    expect(result).toEventually(equal([cardSet]))
                }
            }
        }
    }
}
extension CardSet: Equatable {
    public static func == (lhs: CardSet, rhs: CardSet) -> Bool {
        return lhs.code == rhs.code
            && lhs.name == rhs.name
            && lhs.releaseDate == rhs.releaseDate
    }
}

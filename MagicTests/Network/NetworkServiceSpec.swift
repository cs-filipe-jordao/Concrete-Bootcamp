//
//  NetworkServiceSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import Magic

class NetworkServiceSpec: QuickSpec {
    override func spec() {
        describe("A NetworkService") {
            let host = "localhost"
            var sut: NetworkService!

            beforeEach {
                sut = NetworkService(baseUrl: URL(string: "http://\(host)")!)
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            context("When fetching the list of CardSets") {
                var sets: [CardSet]?
                var error: Error?

                beforeEach {
                    self.stubSuccessSetsRequests(for: host)
                    sut.fetchSets {
                        switch $0 {
                        case let .success(s):
                            sets = s
                        case let .failure(err):
                            error = err
                        }
                    }
                }

                it("Should complete with the expected ammount of sets") {
                    expect(error).toEventually(beNil())
                    expect(sets?.count).toEventually(equal(446))
                }
            }
            context("When fetching the list of Cards of a CardSet") {
                var cards: [Card]?
                var error: Error?
                let cardSet = CardSet(code: "10E", name: "Tenth Edition", releaseDate: "2007-07-13")

                beforeEach {
                    self.stubSuccessCardsRequests(for: host, and: cardSet)
                    sut.fetchCards(from: cardSet, page: 0) {
                        switch $0 {
                        case let .success(c):
                            cards = c
                        case let .failure(err):
                            error = err
                        }
                    }
                }

                it("Should complete with the expected ammount of cards") {
                    expect(error).toEventually(beNil())
                    expect(cards?.count).toEventually(equal(100))
                }
            }
        }
    }

    func stubSuccessSetsRequests(for host: String) {
        stub(condition: isHost(host) && isPath("/v1/sets")) { _ in
            guard let path = OHPathForFile("Sets.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }

    func stubSuccessCardsRequests(for host: String, and cardSet: CardSet) {
        stub(condition: isHost(host) && isPath("/v1/cards") && containsQueryParams(["page": "0", "set": cardSet.code])) { _ in
            guard let path = OHPathForFile("Cards.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}

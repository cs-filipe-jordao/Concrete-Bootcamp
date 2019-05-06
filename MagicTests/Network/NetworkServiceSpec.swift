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

                beforeEach {
                    self.stubSuccessSetsRequests(for: host)
                    sut.fetchSets {
                        if case let .success(s) = $0 {
                            sets = s
                        }
                    }
                }

                it("Should complete with the expected ammount of sets") {
                    expect(sets?.count).toEventually(equal(446))
                }
            }
            context("When fetching the list of Cards of a CardSet") {
                var cards: [Card]?
                let cardSet = CardSet(code: "10E",
                                      name: "Tenth Edition",
                                      releaseDate: "2007-07-13")
                beforeEach {
                    self.stubSuccessCardsRequests(for: host, and: cardSet)
                    sut.fetchAllCards(from: cardSet) {
                        if case let .success(c) = $0 {
                            cards = c
                        }
                    }
                }

                it("Should complete with the expected ammount of cards") {
                    expect(cards?.count).toEventually(equal(200))
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

        stub(condition: isHost(host) && isPath("/v1/cards") && containsQueryParams(["page": "1", "set": cardSet.code])) { _ in
            guard let path = OHPathForFile("Cards.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }

            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }

        stub(condition: isHost(host) && isPath("/v1/cards") && containsQueryParams(["page": "2", "set": cardSet.code])) { _ in
          return OHHTTPStubsResponse(
            jsonObject: ["cards": []],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
}

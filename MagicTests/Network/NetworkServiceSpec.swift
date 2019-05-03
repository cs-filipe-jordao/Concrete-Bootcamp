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
            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            context("When fetching the list of CardSets") {
                let host = "localhost"
                var sut: NetworkService!

                var sets: [CardSet]?
                var error: Error?

                beforeEach {
                    self.stubSuccessSetsRequests(for: host)
                    sut = NetworkService(baseUrl: URL(string: "http://\(host)")!)
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
                    expect(sets?.count).toEventually(equal(2))
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
}

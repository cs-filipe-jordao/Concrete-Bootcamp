//
//  CacheSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Quick
import Nimble

@testable import Magic

class CacheSpec: QuickSpec {
    override func spec() {
        describe("A Cache") {
            context("When theres a object inside the cache") {
                var sut: Cache<Int>!
                var traveller: TimeTravelling!

                let key = "CacheKey"
                let timeout = 500.0
                let value = 15

                beforeEach {
                    traveller = TimeTravelling(date: Date())
                    sut = Cache<Int>(dateGenerator: traveller.currentDate)

                    sut.setObject(value, for: key, timeout: timeout)
                }

                context("And it has expired") {
                    beforeEach {
                        traveller.timeTravel(by: timeout)
                    }

                    it("Shouldn't contain the object") {
                        expect(sut.object(for: key)).to(beNil())
                    }
                }

                context("And it hasnt expired") {
                    beforeEach {
                        traveller.timeTravel(by: timeout/2)
                    }

                    it("Should contain de object") {
                        expect(sut.object(for: key)).to(equal(value))
                    }
                }
            }
        }
    }
}


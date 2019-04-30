//
//  CardSetSpec.swift
//  MagicAPITests
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Quick
import Nimble

@testable import Magic

class CardSetSpec: QuickSpec {
    override func spec() {
        describe("A CardSet") {
            context("When loaded from a json") {
                let json: [String: Any] = ["code": "KTK",
                                           "name": "Khans of Tarkir",
                                           "releaseDate": "2014-09-26"]

                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                let sut = jsonData.map{ try? JSONDecoder().decode(CardSet.self, from: $0) }

                it("Should match its attributes with the json") {
                    let name = json["name"] as? String
                    expect(sut??.name).to(equal(name))

                    let code = json["code"] as? String
                    expect(sut??.code).to(equal(code))

                    let releaseDate = json["releaseDate"] as? String
                    expect(sut??.releaseDate).to(equal(releaseDate))
                }
            }
        }
    }
}

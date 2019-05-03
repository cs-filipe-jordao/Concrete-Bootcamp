//
//  TypeCardGrouperSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Quick
import Nimble

@testable import Magic

class TypeCardGrouperSpec: QuickSpec {
    override func spec() {
        describe("A TypeCardGrouper") {
            context("When grouping a list of cards") {
                let sut = TypeCardGrouper()

                let card1 = Card(name: "Card1",
                                 type: "something",
                                 types: ["something", "something2"],
                                 cardSet: "asd",
                                 imageURL: nil,
                                 identifier: "Card1")

                let card2 = Card(name: "Card2",
                                 type: "something2",
                                 types: ["something3", "something2"],
                                 cardSet: "asd",
                                 imageURL: nil,
                                 identifier: "Card2")

                let card3 = Card(name: "Card3",
                                 type: "something3",
                                 types: ["something3", "something"],
                                 cardSet: "asd",
                                 imageURL: nil,
                                 identifier: "Card3")

                let cards = [card1, card2, card3]

                let groupedCards = sut.group(cards: cards)

                it("Should match the expected groups") {
                    let expectedGroups = [ "something": [card1, card3],
                                           "something2": [card1, card2],
                                           "something3": [card2, card3]]

                    expect(groupedCards).to(equal(expectedGroups))
                }
            }
        }
    }
}

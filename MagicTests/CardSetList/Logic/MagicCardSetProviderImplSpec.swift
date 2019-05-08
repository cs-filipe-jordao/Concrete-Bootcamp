//
//  MagicCardSetProviderImplSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 08/05/19.
//

import Quick
import Nimble
import RxTest
import RxSwift

@testable import Magic

class MagicCardSetProviderImplSpec: QuickSpec {
    class CardServiceMock: CardService {
        var pages = [[Card]]()

        func fetchCards(from set: CardSet, page: Int) -> Single<[Card]> {
            return .just(pages[page])

        }

        func fetchAllCards(from set: CardSet) -> Single<[Card]> {
            let cards = pages.reduce([], +)

            return .just(cards)
        }
    }

    class CardSetServiceMock: CardSetService {
        var sets = [CardSet]()

        func fetchSets() -> Single<[CardSet]> {
            return .just(sets)
        }
    }

    class GroupingStrategyMock: CardGroupingStrategy {
        var groupName = "group"

        func group(cards: [MagicCard]) -> [GroupKey : [MagicCard]] {
            return [groupName: cards]
        }
    }

    override func spec() {
        describe("A MagicCardSetProviderImpl") {
            context("When fetching a MagicCardSet") {
                let cardServiceMock = CardServiceMock()

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

                cardServiceMock.pages = [[card1], [card2], [card3]]

                let cardSetServiceMock = CardSetServiceMock()

                let cardSet = CardSet(code: "asd", name: "A random card set", releaseDate: "2017-10-10")

                cardSetServiceMock.sets = [cardSet]

                let sut = MagicCardSetProviderImpl(cardService: cardServiceMock,
                                                   cardSetService: cardSetServiceMock)

                let results = try? sut.fetch(page: 0).toBlocking().single()


                let expectedCard1 = MagicCard(name: "Card1",
                                              type: "something",
                                              types: ["something", "something2"],
                                              cardSet: "asd",
                                              imageURL: nil,
                                              identifier: "Card1")

                let expectedCard2 = MagicCard(name: "Card2",
                                              type: "something2",
                                              types: ["something3", "something2"],
                                              cardSet: "asd",
                                              imageURL: nil,
                                              identifier: "Card2")

                let expectedCard3 = MagicCard(name: "Card3",
                                              type: "something3",
                                              types: ["something3", "something"],
                                              cardSet: "asd",
                                              imageURL: nil,
                                              identifier: "Card3")

                let date = Date.date(from: "2017-10-10")
                let expectedSet = MagicCardSet(code: "asd",
                                               name: "A random card set",
                                               releaseDate: date)


                it("Should fetch the expected MagicCardSet") {
                    expect(results?.set).to(equal(expectedSet))
                }

                it("Should fetch the cards of the set") {
                    expect(results?.cards).to(equal([expectedCard1, expectedCard2, expectedCard3]))
                }
            }
        }
    }
}


extension MagicCardSet: Equatable {
    public static func == (lhs: MagicCardSet, rhs: MagicCardSet) -> Bool {
        return lhs.code == rhs.code
            && lhs.name == rhs.name
            && lhs.releaseDate == rhs.releaseDate
    }
}

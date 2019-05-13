//
//  CardListDetailViewModelImplSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Quick
import Nimble
import RxTest
import RxSwift
import RxBlocking

@testable import Magic

class CardListDetailViewModelImplSpec: QuickSpec {

    class IsFavoriteCardUseCaseMock: IsFavoriteCardUseCase {
        func favorites(from cards: [MagicCard]) -> Single<[(card: MagicCard, isfavorite: Bool)]> {
            return .just(cards.map { ($0, false) })
        }
    }

    class AddFavoriteUseCaseMock: AddFavoriteUseCase {
        var cards = [MagicCard]()
        func toggleFavorite(card: MagicCard) {
            cards.append(card)
        }
    }

    override func spec() {
        describe("A CardListDetailViewModelImpl") {
            var sut: CardListDetailViewModelImpl!
            var isFavoriteUseCase: IsFavoriteCardUseCaseMock!
            var addFavoriteUseCase: AddFavoriteUseCaseMock!
            let card = MagicCard(name: "A random",
                                 type: "A type",
                                 types: ["A type"],
                                 cardSet: "15A",
                                 imageURL: nil,
                                 identifier: "1231")

            beforeEach {
                isFavoriteUseCase = IsFavoriteCardUseCaseMock()
                addFavoriteUseCase = AddFavoriteUseCaseMock()
                sut = CardListDetailViewModelImpl(cards: [card],
                                                  isFavoriteUseCase: isFavoriteUseCase,
                                                  addFavoriteUseCase: addFavoriteUseCase)
            }

            context("When initialized") {
                it("Should emit the initial state") {
                    let state = try? sut.state.toBlocking().first()

                    expect(state).to(equal(.initial))
                }

                context("And a didLoadEvent occurs") {
                    beforeEach {
                        sut.bindDidLoad(.just(Void()))
                    }

                    it("Should change the state to loaded") {
                        let state = try? sut.state.toBlocking().first()

                        expect(state).to(equal(.loaded([CardDetailViewModel(imageURL: nil)])))
                    }
                }

                context("And a favorite event occurs") {
                    beforeEach {
                        sut.bindFavoriteToggle(.just(0))
                    }

                    it("Should save the favorited card") {
                        let favoriteCards = addFavoriteUseCase.cards

                        expect(favoriteCards).to(equal([card]))
                    }
                }
            }
        }
    }
}

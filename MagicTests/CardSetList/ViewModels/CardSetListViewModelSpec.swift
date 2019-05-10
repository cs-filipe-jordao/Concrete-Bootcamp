//
//  CardSetListViewModelSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 09/05/19.
//

import Quick
import Nimble
import RxTest
import RxSwift

@testable import Magic

class MagicCardSetListViewModelSpec: QuickSpec {
    class MockCardSetProvider: MagicCardSetProvider {
        var cardSet: Single<MagicCardSet>!

        func fetch(page: Int) -> Single<MagicCardSet> {
            return cardSet
        }
    }

    class MockGroupingStrategy: CardGroupingStrategy {
        func group(cards: [MagicCard]) -> [GroupKey : [MagicCard]] {
            return ["group": cards]
        }
    }

    override func spec() {
        describe("A CardSetListViewModel") {
            var provider: MockCardSetProvider!
            var groupingStrategy: MockGroupingStrategy!
            var sut: CardSetListViewModel!

            beforeEach {
                provider = MockCardSetProvider()
                groupingStrategy = MockGroupingStrategy()
                sut = CardSetListViewModel(dataSource: provider,
                                           groupingStrategy: groupingStrategy)
            }

            context("When initialized") {
                it("Should emit the initial state") {
                    let state = try? sut.state.toBlocking().first()
                    expect(state).to(equal(.initial))
                }
            }

            context("When a didLoad event occurs") {
                context("And the fetch succeeds") {
                    var disposable: Disposable!
                    var states = [CardSetListViewModel.State]()
                    let set = MagicCardSet(code: "15A",
                                           name: "A random Cardset",
                                           releaseDate: nil,
                                           cards: [])
                    beforeEach {
                        provider.cardSet = .just(set)

                        disposable = sut.state.drive(onNext: { state in
                            states.append(state)
                        })

                        sut.bindDidLoad(.just(Void()))
                    }

                    afterEach {
                        disposable.dispose()
                    }

                    it("Should emit the expected states") {
                        let cells = [TextCellViewModel(type: "group")]
                        let expectedSection = CollectionViewSectionViewModel(title: set.name, cells: cells)
                        expect(states).to(equal([.initial, .loading, .loaded([expectedSection])]))
                    }
                }

                context("And the fetch fails") {
                    var disposable: Disposable!
                    var states = [CardSetListViewModel.State]()
                    beforeEach {
                        provider.cardSet = .error(NSError(domain: "", code: 0, userInfo: nil))

                        disposable = sut.state.drive(onNext: { state in
                            states.append(state)
                        })

                        sut.bindDidLoad(.just(Void()))
                    }

                    afterEach {
                        disposable.dispose()
                    }

                    it("Should emit the expected states") {
                        expect(states).to(equal([.initial, .loading, .error("Something wrong happened")]))
                    }

                }
            }
        }
    }
}

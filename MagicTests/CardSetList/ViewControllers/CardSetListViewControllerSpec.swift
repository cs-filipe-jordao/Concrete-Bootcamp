//
//  CardSetListViewControllerSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
import RxCocoa
import RxBlocking

@testable import Magic

class CardSetListViewControllerSpec: QuickSpec {
    class CardSetListViewModelMock: CardSetListViewModel {
        var state: Driver<State>
        let stateRelay = BehaviorRelay(value: State.initial)

        init() {
            state = stateRelay.asDriver()
        }

        let didLoadRelay = BehaviorRelay(value: Void())
        let endOfPageRelay = BehaviorRelay(value: Void())
        let disposeBag = DisposeBag()

        func bindDidLoad(_ observable: Driver<Void>) {
            observable.drive(didLoadRelay)
                .disposed(by: disposeBag)
        }

        func bindEndOfPage(_ observable: Driver<Void>) {
            observable.drive(endOfPageRelay)
                .disposed(by: disposeBag)
        }
    }

    override func spec() {
        describe("A CardSetListViewController") {
            var sut: CardSetListViewController!
            var viewModel: CardSetListViewModelMock!

            beforeEach {
                viewModel = CardSetListViewModelMock()
                sut = CardSetListViewController(viewModel: viewModel)
            }

            context("When the viewDidLoad functions is called") {
                var didLoad = false
                var disposable: Disposable?
                beforeEach {
                    disposable = viewModel.didLoadRelay.subscribe({ _ in didLoad = true })

                    sut.viewDidLoad()
                }

                it("Should notify the viewmodel") {
                    expect(didLoad).to(beTrue())
                }

                afterEach {
                    disposable?.dispose()
                }
            }
        }
    }
}

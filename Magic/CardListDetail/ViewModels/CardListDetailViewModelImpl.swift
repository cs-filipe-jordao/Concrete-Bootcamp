//
//  CardListDetailViewModelImpl.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Foundation
import RxSwift
import RxCocoa
class CardListDetailViewModelImpl {
    let state: Driver<CardListDetailState>

    let cards: [MagicCard]

    private let privateState: BehaviorRelay<CardListDetailState>
    private let disposeBag = DisposeBag()
    private let isFavoriteUseCase: IsFavoriteCardUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase

    init(cards: [MagicCard], isFavoriteUseCase: IsFavoriteCardUseCase, addFavoriteUseCase: AddFavoriteUseCase) {
        self.cards = cards
        self.addFavoriteUseCase = addFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
        privateState = BehaviorRelay(value: .initial)
        state = privateState.asDriver()
    }
}

extension CardListDetailViewModelImpl: CardListDetailViewModel {
    func bindDidLoad(_ observable: Driver<Void>) {
        observable
            .asObservable()
            .withLatestFrom(Observable.just(cards))
            .flatMap(isFavoriteUseCase.favorites)
            .map { $0.map {$0.card }}
            .map { $0.map { CardViewModel(imageURL: $0.imageURL)} }
            .map {CardListDetailState.loaded($0) }
            .asDriver(onErrorDriveWith: .empty())
            .drive(privateState)
            .disposed(by: disposeBag)
    }

    func bindSave(_ observable: Driver<Int>) {
        observable
            .withLatestFrom(Driver.just(cards), resultSelector: { $1[$0] })
            .drive(onNext: addFavoriteUseCase.toggleFavorite)
            .disposed(by: disposeBag)
    }
}

//
//  CardSetListViewModel.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

class CardSetListViewModel {
    var sets = [MagicCardSet]()
    let cardSetProvider: MagicCardSetProvider
    weak var output: CardSetListViewModelOutput?

    init(cardSetProvider: MagicCardSetProvider) {
        self.cardSetProvider = cardSetProvider
    }
}

extension CardSetListViewModel: CardSetListViewModelInput {
    func didLoad() {
        output?.showLoading()
        cardSetProvider.fetchSet(number: 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(set):
                self.sets = [set]
                self.output?.reloadData()
            case .failure:
                self.output?.showError()
            }
        }
    }
}

//
//  CardListDetailCoordinator.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import UIKit

class CardListDetailCoordinator {
    func create(cards: [MagicCard]) -> UIViewController {
        let isFavUseCase = IsFavoriteCardUseCaseImpl()
        let addUseCase = AddFavoriteCardUseCaseImpl()
        let viewModel = CardListDetailViewModelImpl(cards: cards,
                                                    isFavoriteUseCase: isFavUseCase,
                                                    addFavoriteUseCase: addUseCase)

        let viewController = CardListDetailViewController(viewModel: viewModel)

        return viewController
    }
}

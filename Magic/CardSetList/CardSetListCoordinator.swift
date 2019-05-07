//
//  CardSetListCoordinator.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import UIKit

class CardSetListCoordinator {
    func create() -> UIViewController {
        let vc = CardSetListViewController()
        let networkService = NetworkService(baseUrl: URL(string: "https://api.magicthegathering.io")!)
        let cachedCardSetService = CachedCardSetService(service: networkService)
        let groupingStrategy = TypeCardGroupingStrategy()
        let magicCardSetProvider = MagicCardSetProviderImpl(cardService: networkService,
                                                            cardSetService: cachedCardSetService,
                                                            groupingStrategy: groupingStrategy)

        let viewModel = CardSetListViewModel(cardSetProvider: magicCardSetProvider)
        viewModel.output = vc
        vc.vm = viewModel

        return vc
    }
}

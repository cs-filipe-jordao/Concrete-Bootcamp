//
//  CardSetListCoordinator.swift
//  Magic
//
//  Created by filipe.n.jordao on 10/05/19.
//

import UIKit

class CardSetListCoordinator {
    func create() -> UIViewController {
        let url = URL(string: "https://api.magicthegathering.io")!
        let networService = NetworkService(baseUrl: url)
        let cachedSetService = CachedCardSetService(service: networService)
        let dataProvider = MagicCardSetProviderImpl(cardService: networService,
                                                    cardSetService: cachedSetService)
        let typeGroupingStrategy = TypeCardGroupingStrategy()

        let viewModel = CardSetListViewModel(dataSource: dataProvider,
                                             groupingStrategy: typeGroupingStrategy)
        let viewController = CardSetListViewController(viewModel: viewModel)

        return viewController
    }
}

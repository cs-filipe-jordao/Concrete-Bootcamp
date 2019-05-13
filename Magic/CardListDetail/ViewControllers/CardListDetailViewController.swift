//
//  CardListDetailView.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import UIKit
import RxCocoa
import RxSwift

class CardListDetailViewController: UIViewController {
    let cardListView = CardListDetailView()

    let viewModel: CardListDetailViewModel?

    init(viewModel: CardListDetailViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardListDetailViewController {
    override func loadView() {
        view = cardListView
    }
}

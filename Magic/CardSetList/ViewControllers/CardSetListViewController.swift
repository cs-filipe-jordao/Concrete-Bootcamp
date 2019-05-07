//
//  CardSetListViewController.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import UIKit

class CardSetListViewController: UIViewController {
    let listView = CardSetListView()
    var vm: CardSetListViewModelInput?
}

extension CardSetListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.didLoad()
        listView.collection.dataSource = self
        listView.collection.delegate = self
        listView.collection.register(TypeCell.self, forCellWithReuseIdentifier: "id")
    }

    override func loadView() {
        view = listView
    }
}

extension CardSetListViewController: CardSetListViewModelOutput {
    func reloadData() {
        listView.collection.reloadData()
    }

    func showError() {
    }

    func showLoading() {

    }
}

extension CardSetListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id",
                                                            for: indexPath) as? TypeCell
            else { return UICollectionViewCell() }
        cell.typeLabel.text = "Creature"
        return cell
    }
}

extension CardSetListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 10)
    }
}

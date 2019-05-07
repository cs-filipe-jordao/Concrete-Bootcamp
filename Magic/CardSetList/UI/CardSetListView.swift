//
//  CardSetListView.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//  Copyright © 2019 filipe.n.jordao. All rights reserved.
//

import UIKit

final class CardSetListView: UIView {
    let background = UIImageView()

    let collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15

        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardSetListView: CodeView {
    func setupViews() {
        background.image = #imageLiteral(resourceName: "Background")

        collection.backgroundView = nil
        collection.backgroundColor = .clear
    }

    func setupHierarchy() {
        [ background,
          collection ].forEach(self.addSubview)
    }

    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.top
                .bottom
                .left
                .right
                .equalTo(self)
        }

        collection.snp.makeConstraints { make in
            make.top
                .bottom
                .left
                .right
                .equalTo(self)
        }
    }
}

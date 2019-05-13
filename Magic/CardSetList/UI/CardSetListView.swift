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
    let activityIndicator = UIActivityIndicatorView(style: .white)

    let collection: UICollectionView = {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        collection.backgroundView = nil
        collection.backgroundColor = .clear

        return collection
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
        activityIndicator.startAnimating()
    }

    func setupHierarchy() {
        [ background,
          collection,
          activityIndicator ].forEach(self.addSubview)
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

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(self)
        }
    }
}

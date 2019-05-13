//
//  CardListDetailView.swift
//  Magic
//
//  Created by filipe.n.jordao on 13/05/19.
//

import UIKit

class CardListDetailView: UIView {
    let background = UIImageView()

    let closeButton: UIButton = {
        let button = UIButton()

        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)

        return button
    }()

    let addToDeckButton: UIButton = {
        let button =  UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("favorite card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5

        return button
    }()

    let collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

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

extension CardListDetailView: CodeView {
    func setupViews() {
        background.image = #imageLiteral(resourceName: "Background")
    }

    func setupHierarchy() {
        [ background,
          collection,
          closeButton,
          addToDeckButton ].forEach(self.addSubview)
    }

    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.top
                .bottom
                .left
                .right
                .equalTo(self)
        }

        closeButton.snp.makeConstraints { make in
            make.left
                .equalToSuperview().inset(10)

            if #available(iOS 11.0, *) {
                make.top
                    .equalTo(safeAreaLayoutGuide.snp.topMargin)
                    .inset(10)
            } else {
                make.top
                    .equalToSuperview().inset(10)
            }

            make.size.equalTo(CGSize(width: 44, height: 44))
        }

        collection.snp.makeConstraints { make in
            make.left
                .right
                .equalTo(self)

            make.top.equalTo(closeButton.snp.bottom)
        }

        addToDeckButton.snp.makeConstraints { make in
            make.top
                .equalTo(collection.snp.bottom)
                .inset(-16)

            if #available(iOS 11.0, *) {
                make.bottom
                    .equalTo(safeAreaLayoutGuide.snp.bottomMargin)
                    .inset(16)
            } else {
                make.bottom
                    .equalToSuperview().inset(16)
            }

            make.height.equalTo(48)

            make.left
                .right
                .equalToSuperview()
                .inset(16)
        }
    }
}

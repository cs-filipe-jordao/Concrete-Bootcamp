//
//  CollectionViewSectionHeader.swift
//  Magic
//
//  Created by filipe.n.jordao on 10/05/19.
//

import UIKit
import SnapKit

class CollectionViewSectionHeader: UICollectionReusableView {
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewSectionHeader: CodeView {
    func setupHierarchy() {
        addSubview(title)
    }

    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.left
                .right
                .bottom
                .top
                .equalTo(self)
        }
    }
}

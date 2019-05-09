//
//  CardCell.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import UIKit
import SnapKit

final class CardCell: UICollectionViewCell {
    let banner = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardCell: CodeView {
    func setupViews() {
        banner.contentMode = .scaleAspectFill
    }

    func setupHierarchy() {
        contentView.addSubview(banner)
    }

    func setupConstraints() {
        banner.snp.makeConstraints { make in
            make.left
                .top
                .bottom
                .right
                .equalTo(contentView)
        }
    }
}

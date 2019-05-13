//
//  TextCell.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import UIKit

final class TextCell: UICollectionViewCell {
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.8318908215, green: 0.8277270198, blue: 0.8056753278, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)

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

extension TextCell: CodeView {
    func setupHierarchy() {
        contentView.addSubview(typeLabel)
    }

    func setupConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.left
                .right
                .centerY
                .equalTo(contentView)
        }
    }
}

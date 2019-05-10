//
//  CardCell.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Nuke
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

    func loadImage(url: URL?) {
        guard let url = url else {
            banner.image = #imageLiteral(resourceName: "cardback")
            return
        }

        Nuke.loadImage(
            with: url,
            options: ImageLoadingOptions(
                placeholder: #imageLiteral(resourceName: "cardback"),
                transition: .fadeIn(duration: 0.33)
            ),
            into: banner)
    }
}

extension CardCell: CodeView {
    func setupViews() {
        banner.contentMode = .scaleAspectFill
        banner.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
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

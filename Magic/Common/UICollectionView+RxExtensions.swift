//
//  UICollectionView+RxExtensions.swift
//  Magic
//
//  Created by filipe.n.jordao on 10/05/19.
//

import UIKit
import RxCocoa
import RxSwift

extension UICollectionView {
    func isNearBottom() -> Driver<Bool> {
        return self.rx.contentOffset
            .map(isNearBottom)
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
    }

    private func isNearBottom(point: CGPoint) -> Bool {
        return point.y + self.frame.size.height + 20 > self.contentSize.height
    }
}

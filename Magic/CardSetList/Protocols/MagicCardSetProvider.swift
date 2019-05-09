//
//  MagicCardSetProvider.swift
//  Magic
//
//  Created by filipe.n.jordao on 08/05/19.
//

import Foundation
import RxSwift

protocol MagicCardSetProvider {
    func fetch(page: Int) -> Single<MagicCardSet>
}

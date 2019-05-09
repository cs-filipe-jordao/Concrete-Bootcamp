//
//  CardGroupingStrategy.swift
//  Magic
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Foundation

protocol CardGroupingStrategy {
    typealias GroupKey = String
    func group(cards: [MagicCard]) -> [GroupKey: [MagicCard]]
}

//
//  CardGroupingStrategy.swift
//  Magic
//
//  Created by filipe.n.jordao on 03/05/19.
//

import Foundation

protocol CardGroupingStrategy {
    associatedtype GroupKey: Hashable
    func group(cards: [Card]) -> [GroupKey: [Card]]
}

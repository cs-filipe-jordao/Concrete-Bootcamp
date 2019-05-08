//
//  MagicCardSetProvider.swift
//  Magic
//
//  Created by filipe.n.jordao on 08/05/19.
//

import Foundation

protocol MagicCardSetProvider {
    func fetch(page: Int, completion: @escaping (Result<CardSet, Error>) -> Void)
}
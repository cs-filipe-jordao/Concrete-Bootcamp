//
//  MagicCardSetProvider.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

protocol MagicCardSetProvider {
    func fetchSet(number: Int, completion: @escaping (Result<MagicCardSet, Error>) -> Void)
}

//
//  CardSetListViewModelOutput.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

protocol CardSetListViewModelOutput: class {
    func reloadData()
    func showError()
    func showLoading()
}

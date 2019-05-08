//
//  CodeView.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

protocol CodeView {
    func setupViews()
    func setupHierarchy()
    func setupConstraints()
}

extension CodeView {
    func configureView() {
        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    func setupViews() {}
}

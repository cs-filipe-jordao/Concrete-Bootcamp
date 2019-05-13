//
//  CollectionViewSectionHeaderSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 10/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Magic

class CollectionViewSectionHeaderSpec: QuickSpec {
    override func spec() {
        describe("A CollectionViewSectionHeader") {
            context("When created") {
                let sut = TextCell(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
                sut.typeLabel.text = "Creature"
                it("Should render as expected") {
                    expect(sut) == snapshot("CollectionSectionHeader")
                }
            }
        }
    }
}

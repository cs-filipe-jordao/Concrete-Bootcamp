//
//  TypeCellSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Magic

class TypeCellSpec: QuickSpec {
    override func spec() {
        describe("A TypeCell") {
            context("When created") {
                let sut = TypeCell(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
                sut.typeLabel.text = "Creature"
                it("Should render as expected") {
                    expect(sut) == snapshot("TypeCell")
                }
            }
        }
    }
}

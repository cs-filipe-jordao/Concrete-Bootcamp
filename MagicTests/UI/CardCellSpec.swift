//
//  CardCellSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Magic

class CardCellSpec: QuickSpec {
    override func spec() {
        describe("A CardCell") {
            context("When created") {
                let cell = CardCell(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
                cell.banner.image =  UIImage(named: "CardTestAsset")
                it("Should render as expected") {
                    expect(cell) == snapshot("CardCell")
                }
            }
        }
    }
}

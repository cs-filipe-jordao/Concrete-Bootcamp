//
//  CardSetListViewSpec.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Magic

class CardSetListViewSpec: QuickSpec {
    override func spec() {
        describe("A CardSetListView") {
            context("When its created") {
                let sut = CardSetListView(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
                it("Should render as expected") {
                    expect(sut) == snapshot("CardSetListView")
                }
            }
        }
    }
}

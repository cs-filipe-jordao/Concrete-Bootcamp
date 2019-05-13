//
//  CardSetListDetailView.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 13/05/19.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Magic

class CardSetListDetailViewSpec: QuickSpec {
    override func spec() {
        describe("A CardListDetailView") {
            context("When its created") {
                let sut = CardListDetailView(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
                it("Should render as expected") {
                    expect(sut) == snapshot("CardListDetailView")
                }
            }
        }
    }
}

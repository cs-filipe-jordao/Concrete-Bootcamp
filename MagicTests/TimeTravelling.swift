//
//  TimeTravelling.swift
//  MagicTests
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Foundation

class TimeTravelling {
    private var date: Date

    init(date: Date) {
        self.date = date
    }

    func timeTravel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }

    func currentDate() -> Date {
        return date
    }
}

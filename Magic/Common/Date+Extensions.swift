//
//  Date+Extensions.swift
//  Magic
//
//  Created by filipe.n.jordao on 07/05/19.
//

import Foundation

extension Date {
    static func date(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: string)
    }
}

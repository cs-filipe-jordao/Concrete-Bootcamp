//
//  Date+Extensions.swift
//  Magic
//
//  Created by filipe.n.jordao on 08/05/19.
//

import Foundation

extension Date {
    static func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.date(from: string)
    }
}

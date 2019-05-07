//
//  Card.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//  Copyright © 2019 filipe.n.jordao. All rights reserved.
//

import Foundation

struct Card: Codable, Hashable {
    let name, type: String
    let types: [String]
    let cardSet: String
    let imageURL: String?
    let identifier: String

    enum CodingKeys: String, CodingKey {
        case name, type, types
        case cardSet = "set"
        case imageURL = "imageUrl"
        case identifier = "id"
    }
}

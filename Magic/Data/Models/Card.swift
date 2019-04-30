//
//  Card.swift
//  MagicAPI
//
//  Created by filipe.n.jordao on 30/04/19.
//  Copyright © 2019 filipe.n.jordao. All rights reserved.
//

import Foundation

struct Card: Codable {
    let name, type: String
    let supertypes: [String]
    let types: [String]
    let subtypes: [String]
    let cardSet: String
    let number: String
    let multiverseid: Int
    let imageURL: String
    let printings: [String]
    let identifier: String

    enum CodingKeys: String, CodingKey {
        case name, type, supertypes, types, subtypes
        case cardSet = "set"
        case number, multiverseid
        case imageURL = "imageUrl"
        case printings
        case identifier = "id"
    }
}

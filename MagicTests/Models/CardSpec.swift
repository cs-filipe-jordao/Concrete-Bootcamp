//
//  CardSoec.swift
//  MagicAPITests
//
//  Created by filipe.n.jordao on 30/04/19.
//

import Quick
import Nimble

@testable import Magic

class CardSpec: QuickSpec {
    override func spec() {
        describe("A Card") {
            context("When loaded from a json") {
                let json: [String: Any] = [ "name": "Khans of Tarkir",
                                            "type": "Angel",
                                            "supertypes": [String](),
                                            "types": [String](),
                                            "subtypes": [String](),
                                            "set": "KTK",
                                            "number": "12e",
                                            "multiverseid": 10,
                                            "imageUrl": "https://google.com",
                                            "printings": [String](),
                                            "id": "12312" ]

                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                let sut = jsonData.map{ try? JSONDecoder().decode(Card.self, from: $0) }

                it("Should match its attributes with the json") {
                    let name = json["name"] as? String
                    expect(sut??.name).to(equal(name))

                    let type = json["type"] as? String
                    expect(sut??.type).to(equal(type))

                    let supertypes = json["supertypes"] as? [String]
                    expect(sut??.supertypes).to(equal(supertypes))

                    let types = json["types"] as? [String]
                    expect(sut??.types).to(equal(types))

                    let subtypes = json["subtypes"] as? [String]
                    expect(sut??.subtypes).to(equal(subtypes))

                    let set = json["set"] as? String
                    expect(sut??.cardSet).to(equal(set))

                    let number = json["number"] as? String
                    expect(sut??.number).to(equal(number))

                    let multiverseid = json["multiverseid"] as? Int
                    expect(sut??.multiverseid).to(equal(multiverseid))

                    let imageUrl = json["imageUrl"] as? String
                    expect(sut??.imageURL).to(equal(imageUrl))

                    let printings = json["printings"] as? [String]
                    expect(sut??.printings).to(equal(printings))

                    let identifier = json["id"] as? String
                    expect(sut??.identifier).to(equal(identifier))
                }
            }
        }
    }
}

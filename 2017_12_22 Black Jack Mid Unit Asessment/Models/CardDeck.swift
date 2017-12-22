//
//  CardDeck.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct CardDeck: Codable {
    let deckId: String
    let successfulCall: Bool
    static var players = [Player]()
    enum CodingKeys: String, CodingKey {
        case successfulCall = "success"
        case deckId = "deck_id"
    }
}

/*
let string = """
"shuffled": true,
"deck_id": "np68pufihjib",
"remaining": 312,
"success": true
"""
*/

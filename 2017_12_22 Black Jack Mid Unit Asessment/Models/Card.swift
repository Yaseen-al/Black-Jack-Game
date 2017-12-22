//
//  Card.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct CardWraper: Codable {
    let cards: [Card]
}
struct Card: Codable {
    let code: String
    let suit: String
    let image: String
    let value: String
    var valueInt: Int{
        if let value = Int(value){
            return value
        }else{
            switch value.lowercased(){
            case "ace":
            return 11
            default:
            return 10
            }
        }
    }
    let images: ImageWraper
}
struct ImageWraper: Codable {
    let svg: String
    let png: String
}

let cardStr = """
{
"code": "KS",
"image": "http://deckofcardsapi.com/static/img/KS.png",
"value": "KING",
"suit": "SPADES",
"images": {
"svg": "http://deckofcardsapi.com/static/img/KS.svg",
"png": "http://deckofcardsapi.com/static/img/KS.png"
}
}
"""

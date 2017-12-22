//
//  Player.swift
//  2017_12_22 Black Jack Mid Unit Asessment
//
//  Created by C4Q on 12/22/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct Player: Codable {
    var cardSet: [Card]
    var score: Int{
        return  cardSet.map{$0.valueInt}.reduce(0, +)
    }
    var win: Bool{
        if score != 30{
            return false
        }else{
            return true
        }
    }
}

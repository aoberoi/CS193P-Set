//
//  Deck.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import Foundation

struct Deck {
    private(set) var cards = [Card]()
    
    init() {
        // TODO: this is silly
        for number in Card.Feature.all {
            for symbol in Card.Feature.all {
                for shading in Card.Feature.all {
                    for color in Card.Feature.all {
                        cards.append(Card(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

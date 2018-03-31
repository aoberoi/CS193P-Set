//
//  SetDeck.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import Foundation

struct SetDeck {
    private(set) var cards = [SetCard]()
    
    init() {
        // TODO: this is silly
        for number in SetCard.Feature.all {
            for symbol in SetCard.Feature.all {
                for shading in SetCard.Feature.all {
                    for color in SetCard.Feature.all {
                        cards.append(SetCard(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
    }
    
    mutating func draw() -> SetCard? {
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

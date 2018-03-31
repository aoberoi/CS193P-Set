//
//  Card.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import Foundation

struct Card {
    let number: Feature
    let symbol: Feature
    let shading: Feature
    let color: Feature
    
    enum Feature {
        case A
        case B
        case C
        
        static let all: [Feature] = [.A, .B, .C]
    }
}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (
            (lhs.number == rhs.number) &&
            (lhs.symbol == rhs.symbol) &&
            (lhs.shading == rhs.shading) &&
            (lhs.color == rhs.color)
        )
    }
}

extension Collection where Element: Hashable {
    var asSet: Set<Element> {
        return Set(self)
    }
    
    var areUnqiue: Bool {
        return asSet.count == count
    }
    
    var areIdentical: Bool {
        return asSet.count == 1
    }
}

extension Collection where Element == Card {
    func containsSet() -> Bool {
        if count == 3 {
            // note: could do a little better with reflect API
            let numbers = map({ $0.number })
            let symbols = map({ $0.symbol })
            let shadings = map({ $0.shading })
            let colors = map({ $0.color })
            return ((numbers.areUnqiue || numbers.areIdentical) && (symbols.areUnqiue || symbols.areIdentical) && (shadings.areUnqiue || shadings.areIdentical) && (colors.areUnqiue || colors.areIdentical))
        }
        return false
    }
}


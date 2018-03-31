//
//  SetGame.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import Foundation

struct SetGame {
    private let maximumCards: Int
    private var deck = SetDeck()
    private(set) var currentlyPlayed = [SetCard?]()
    
    // this is a subset of the cards in currentlyPlayed
    // TODO: can we enforce the above, and somehow limit the use of indexes between this and currentlyPlayed?
    private(set) var selectedCards = [SetCard]()
    
    init(maximumCards: Int) {
        self.maximumCards = maximumCards
        for _ in 0..<12 {
            currentlyPlayed.append(deck.draw())
        }
    }
    
    mutating func select(card: SetCard) {
        if selectedCards.count < 3 {
            // deselection
            if (selectedCards.contains(card)) {
                selectedCards.remove(at: selectedCards.index(of: card)!)
                return
            }
        
            // adding a card to the selection (there could now be a set)
            selectedCards.append(card)
            return
        }
        
        assert(selectedCards.count == 3)
        
        if selectedCards.containsSet() {
            // there was a set, now the next card is selected

            // replace each selected card with a new card
            for selectedCard in selectedCards {
                let index = currentlyPlayed.index(of: selectedCard)!
                currentlyPlayed[index] = deck.draw()
            }
            
            // update selection
            if (selectedCards.contains(card)) {
                selectedCards = []
            } else {
                selectedCards = [card]
            }
        } else {
            // deselect all previously selected and select the card this card (yes, it could be part of the previous selection)
            selectedCards.replaceSubrange(0..<3, with: [card])
        }
    }
}

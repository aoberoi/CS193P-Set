//
//  ViewController.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import UIKit

// TODO: implement scoring with UI

class ViewController: UIViewController {
    
    private lazy var game = SetGame()

    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            for button in cardButtons {
                button.layer.cornerRadius = 8.0
                button.layer.borderWidth = 3.0
            }
        }
    }
    @IBOutlet weak var dealThree: UIButton!
    @IBOutlet weak var score: UILabel!
    
    private var numberOfEmptySpaces: Int {
        return cardButtons.reduce(0) { $0 + ($1.isHidden ? 1 : 0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction func cardTouched(_ sender: UIButton) {
        if let card = card(for: sender) {
            game.select(card: card)
            updateViewFromModel()
        }
    }
    
    @IBAction func dealThreeTouched(_ sender: UIButton) {
        game.dealMore()
        updateViewFromModel()
    }
    
    @IBAction func newGameTouched() {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for button in cardButtons {
            if let card = card(for: button) {
                // make the card visible
                let baseLabel = String(repeating: symbol(for: card.symbol), count: number(for: card.number))
                let label = NSAttributedString(string: baseLabel, attributes: [
                    NSAttributedStringKey.foregroundColor: labelColor(card.color, with: card.shading),
                    NSAttributedStringKey.strokeWidth: strokeWidth(for: card.shading)
                    ])
                button.setAttributedTitle(label, for: UIControlState.normal)
                button.isHidden = false
            } else {
                // make the card invisible
                button.isHidden = true
                button.setAttributedTitle(nil, for: UIControlState.normal)
                button.setTitle(nil, for: UIControlState.normal)
            }
            
            button.layer.borderColor = UIColor.black.cgColor
        }
        
        if (!game.selectedCards.isEmpty) {
            let outlineColor = game.selectedCards.containsSet() ? UIColor.red : UIColor.yellow
            for card in game.selectedCards {
                let button = self.button(for: card)!
                button.layer.borderColor = outlineColor.cgColor
            }
        }
        
        dealThree.isEnabled = (numberOfEmptySpaces >= 3 || game.selectedCards.containsSet()) && game.deck.cards.count >= 3
        
        score.text = "Score: \(game.score)"
    }
    
    private func card(for button:UIButton) -> SetCard? {
        if let index = cardButtons.index(of: button), index < game.currentlyPlayed.count {
            return game.currentlyPlayed[index]
        }
        return nil
    }
    
    private func button(for card:SetCard) -> UIButton? {
        if let index = game.currentlyPlayed.index(of: card) {
            return cardButtons[index]
        }
        return nil
    }
    
    private func number(for feature:SetCard.Feature) -> Int {
        switch feature {
        case .A: return 1
        case .B: return 2
        case .C: return 3
        }
    }
    
    private func symbol(for feature:SetCard.Feature) -> Character {
        switch feature {
        case .A: return "▲" // diamond
        case .B: return "■" // squiggle
        case .C: return "●" // oval
        }
    }
    
    // TODO: not really happy with these argument labels
    private func labelColor(_ color: SetCard.Feature, with shading:SetCard.Feature) -> UIColor {
        let baseColor: UIColor = {
            switch color {
            case .A: return UIColor.red
            case .B: return UIColor.green
            case .C: return UIColor.purple
            }
        }()
        switch shading {
        case .A, .B: return baseColor.withAlphaComponent(1.0) // filled and outline
        case .C: return baseColor.withAlphaComponent(0.15) // striped
        }
    }
    
    private func strokeWidth(for shading:SetCard.Feature) -> Double {
        switch shading {
        case .A: return -4.0 // filled
        case .B: return 4.0 // outline
        case .C: return 0.0 // striped
        }
    }
}


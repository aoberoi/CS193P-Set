//
//  ViewController.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = SetGame(maximumCards: cardButtons.count)

    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            for button in cardButtons {
                button.layer.cornerRadius = 8.0
                button.layer.borderWidth = 3.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction func cardTouched(_ sender: UIButton) {
        if let index = cardButtons.index(of: sender), let card = game.currentlyPlayed[index] {
            game.select(card: card)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for i in cardButtons.indices {
            let button = cardButtons[i]
            if i < game.currentlyPlayed.count, let card = game.currentlyPlayed[i] {
                // make the card visible
                let baseLabel = String(repeating: symbol(for: card.symbol), count: number(for: card.number))
                let label = NSAttributedString(string: baseLabel, attributes: [
                    NSAttributedStringKey.foregroundColor: labelColor(card.color, with: card.shading),
                    NSAttributedStringKey.strokeWidth: strokeWidth(for: card.shading)
                    ])
                button.setAttributedTitle(label, for: UIControlState.normal)
            } else {
                button.isHidden = true
                button.setAttributedTitle(nil, for: UIControlState.normal)
            }
            
            button.layer.borderColor = UIColor.black.cgColor
        }
        
        if (!game.selectedCards.isEmpty) {
            let outlineColor = game.selectedCards.containsSet() ? UIColor.red : UIColor.yellow
            for card in game.selectedCards {
                let index = game.currentlyPlayed.index(of: card)!
                let button = cardButtons[index]
                button.layer.borderColor = outlineColor.cgColor
            }
        }
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
        case .A: return -1.0 // filled
        case .B: return 1.0 // outline
        case .C: return 0.0 // striped
        }
    }
}


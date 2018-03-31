//
//  ViewController.swift
//  Set
//
//  Created by Ankur Oberoi on 3/31/18.
//  Copyright © 2018 Ankur Oberoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let notASet = [
            Card(number: .A, symbol: .B, shading: .A, color: .C),
            Card(number: .A, symbol: .B, shading: .A, color: .B),
            Card(number: .A, symbol: .B, shading: .B, color: .A),
        ]
        print("notASet: \(notASet.containsSet())")
        
        let isASet = [
            Card(number: .A, symbol: .B, shading: .A, color: .C),
            Card(number: .A, symbol: .B, shading: .B, color: .B),
            Card(number: .A, symbol: .B, shading: .C, color: .A),
        ]
        print("isASet: \(isASet.containsSet())")
        
    }

}


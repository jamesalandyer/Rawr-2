//
//  BlueSnail.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class BlueSnail {
    
    //Properties
    private var _name: String = "blue snail"
    private var _hp: Int = 80
    private var _attacks: [String: Int] = [
        "SLIME": 5,
        "SHELLS": 10
        ]
    
    var name: String {
        return _name
    }
    
    var hp: Int {
        return _hp
    }
    
    //METHODS
    
    func attack() -> (power: Int, label: String) {
        let attack = arc4random_uniform(2)
        let rand = arc4random_uniform(6)
        var power: Int!
        var label: String!
        
        if attack == 0 {
            let name = "SLIME"
            if rand == 5 {
                power = 0
                label = "THE \(name) WASNT TOXIC!"
            } else if rand > 0 {
                power = _attacks[name]!
                label = "THE \(name) WAS TOXIC!"
            } else {
                power = _attacks[name]! * 3
                label = "GET \(name)D!"
            }
        } else if attack == 1 {
            let name = "SHELLS"
            if rand >= 4 {
                power = _attacks[name]!
                label = "SOME \(name) HIT YOU!"
            } else if rand > 2 {
                power = _attacks[name]! + 12
                label = "SPIKED \(name) REALLY HURT YOU!"
            } else {
                power = 0
                label = "THE \(name) MISSED YOU!"
            }
        }
        
        
        return (power, label)
    }

    func defense(damage: Int) {
        _hp -= damage
    }
    
    func increaseHealth(multiplier: Int) {
        _hp = _hp + multiplier
    }
    
}
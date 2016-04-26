//
//  PinkSnail.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class PinkSnail {
    
    //Properties
    private var _name: String = "pink snail"
    private var _hp: Int = 70
    private var _attacks: [String: Int] = [
        "PINK SLIME": 10,
        "PINK SHELLS": 10
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
            let name = "PINK SLIME"
            if rand == 5 {
                power = 0
                label = "THE \(name) WASNT TOXIC!"
            } else if rand > 0 {
                power = _attacks[name]! + 5
                label = "THE \(name) WAS TOXIC!"
            } else {
                power = _attacks[name]! * 2
                label = "GET \(name)D!"
            }
        } else if attack == 1 {
            let name = "PINK SHELLS"
            if rand >= 4 {
                power = _attacks[name]!
                label = "SOME \(name) HIT YOU!"
            } else if rand > 2 {
                power = _attacks[name]! + 6
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
//
//  Golem.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Golem {
    
    //Properties
    private var _name: String = "golem"
    private var _hp: Int = 100
    private var _attacks: [String: Int] = [
        "PUNCH": 5,
        "PEBBLE SPLASH": 10,
        "ROCK N ROLL": 16,
    ]
    
    var name: String {
        return _name
    }
    
    var hp: Int {
        return _hp
    }
    
    //METHODS
    
    func attack() -> (power: Int, label: String) {
        let attack = arc4random_uniform(3)
        let rand = arc4random_uniform(6)
        var power: Int!
        var label: String!
        
        if attack == 0 {
            let name = "PUNCH"
            if rand == 5 {
                power = 0
                label = "\(self.name) TRIED TO \(name) YOU!"
            } else if rand > 0 {
                power = _attacks[name]!
                label = "I THINK SOMETHING HIT YOU!"
            } else {
                power = _attacks[name]! * 3
                label = "YOU GOT \(name)ED BY MIKE TYSON!"
            }
        } else if attack == 1 {
            let name = "PEBBLE SPLASH"
            if rand >= 4 {
                power = _attacks[name]!
                label = "\(name) SPLASHED YOU!"
            } else if rand >= 2 {
                power = _attacks[name]! + 10
                label = "\(name) JUST GOT SERIOUS!"
            } else if rand == 1 {
                power = _attacks[name]! + 5
                self._hp -= 5
                label = "\(name) HAD SOME COLATTERAL DAMAGE!"
            } else {
                power = 0
                label = "\(name) DIDNT SPLASH!"
            }
        } else if attack == 2 {
            let name = "ROCK N ROLL"
            if rand >= 4 {
                power = _attacks[name]! - 4
                label = "\(name) HURT YOU!"
            } else if rand > 2 {
                power = _attacks[name]! + 5
                label = "YOU GOT ROCK N ROLLED!"
            } else if rand > 1 {
                power = _attacks[name]!
                label = "\(name)!"
            } else {
                power = 1
                label = "YOU GOT SKIMMED BY \(name)"
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
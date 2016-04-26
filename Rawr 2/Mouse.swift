//
//  Mouse.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Mouse {
    
    //Properties
    private var _name: String = "mouse"
    private var _hp: Int = 110
    private var _attacks: [String: Int] = [
        "NIBBLE": 7,
        "TAIL WHIP": 9,
        "CHEESE": 11,
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
            let name = "NIBBLE"
            if rand >= 4 {
                power = 0
                label = "\(self.name) \(name)D ON NOTHING!"
            } else if rand > 0 {
                power = _attacks[name]!
                label = "YOU GOT \(name)D ON!"
            } else {
                power = _attacks[name]! * 3
                label = "HOLY \(name) YOU WERE EATEN!"
            }
        } else if attack == 1 {
            let name = "TAIL WHIP"
            if rand >= 3 {
                power = _attacks[name]!
                label = "YOU WERE \(name)ED"
            } else if rand == 2 {
                power = _attacks[name]! + 10
                label = "\(name) \(name)!"
            } else {
                power = 0
                label = "\(name) MISSED YOU!"
            }
        } else if attack == 2 {
            let name = "CHEESE"
            if rand >= 4 {
                power = _attacks[name]! - 6
                label = "\(name)!"
            } else if rand > 2 {
                power = _attacks[name]! + 4
                label = "YOU GOT HIT WITH A LOT OF \(name)!"
            } else if rand > 1 {
                power = _attacks[name]!
                label = "ALL YOU NEED IS SOME MACORONI!"
            } else {
                power = 0
                label = "NO \(name) FOR YOU!"
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
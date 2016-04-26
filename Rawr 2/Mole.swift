//
//  Mole.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Mole {
    
    //Properties
    private var _name: String = "mole"
    private var _hp: Int = 95
    private var _attacks: [String: Int] = [
        "DIRT": 2,
        "CLAWS": 10,
        "EARTHQUAKE": 16,
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
            let name = "DIRT"
            if rand == 5 {
                power = 0
                label = "THE \(name) FELL TO THE GROUND!"
            } else if rand > 0 {
                power = _attacks[name]! + 5
                label = "THE \(name) GOT IN YOUR MOUTH!"
            } else {
                power = _attacks[name]! * 10
                label = "YOUR EYES! THEY BURN!"
            }
        } else if attack == 1 {
            let name = "CLAWS"
            if rand >= 4 {
                power = _attacks[name]!
                label = "\(name) SCRAPED YOU!"
            } else if rand >= 2 {
                power = _attacks[name]! + 6
                label = "\(name) ARE OUT AND THEY SLICED THROUGH YOU!"
            } else {
                power = 0
                label = "THE \(name) WERE WEAK!"
            }
        } else if attack == 2 {
            let name = "EARTHQUAKE"
            if rand >= 4 {
                power = _attacks[name]! - 6
                label = "DID THE GROUND SHAKE!"
            } else if rand >= 1 {
                power = _attacks[name]!
                self._hp -= _attacks[name]!
                label = "THAT \(name) WASNT GOOD FOR ANYONE!"
            } else {
                power = _attacks[name]!
                label = "THAT WAS A SCARY \(name)"
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
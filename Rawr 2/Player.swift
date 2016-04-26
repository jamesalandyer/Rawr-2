//
//  Player.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation
import UIKit

class Player {
    
    //Properties
    private var _name: String
    private var _fullHP: Int = 100
    private var _hp: Int = 100
    private var _coins: Int = 0
    private var _attacks: [String: Int] = [
        "BOULDER THROW": 10,
        "BOOM BOOM": 15,
        "ROAD SPIKES": 20,
        "UNKNOWN": 0
    ]
    
    //Getters
    var name: String {
        return _name
    }
    
    var fullHP: Int {
        return _fullHP
    }
    
    var hp: Int {
        return _hp
    }
    
    var coins: Int {
        return _coins
    }
    
    init(name: String) {
        _name = name
    }
    
    //METHODS
    
    func attack(name: String) -> (power: Int, label: String) {
        let rand = arc4random_uniform(6)
        var power: Int!
        var label: String!
        
        if name == "BOULDER THROW" {
            if rand == 5 {
                power = 0
                label = "YOUR \(name) BOUNCED OFF!"
            } else if rand > 0 {
                power = _attacks[name]!
                label = "YOUR \(name) HIT!"
            } else {
                power = _attacks[name]! + 10
                label = "YOUR \(name) WAS VERY EFFECTIVE!"
            }
        } else if name == "BOOM BOOM" {
            if rand >= 4 {
                power = _attacks[name]!
                label = "\(name) DIDNT QUITE MAKE IT!"
            } else if rand >= 2 {
                power = _attacks[name]! + 10
                label = "\(name) LANDED PERFECTLY!"
            } else if rand == 1 {
                power = _attacks[name]! + 5
                self._hp -= 10
                label = "\(name) HAD SOME COLATTERAL DAMAGE!"
            } else {
                power = 0
                label = "\(name) WAS A DUD!"
            }
        } else if name == "ROAD SPIKES" {
            if rand >= 4 {
                power = _attacks[name]! - 7
                label = "\(name) SHOWED THEIR AGE!"
            } else if rand > 2 {
                power = _attacks[name]! + 10
                label = "\(name) WERE SPIKEY!"
            } else if rand > 1 {
                power = _attacks[name]!
                label = "\(name) DID WHAT THEY DO BEST!"
            } else {
                power = Int(ceil(Double(_attacks[name]!) * 0.5)) - 8
                label = "\(name) WERE DULL!"
            }
        } else if name == "UNKNOWN" {
            let rand = arc4random_uniform(20)
            if rand == 19 {
                power = Int(ceil(Double(_attacks[name]!) * 0.5)) + 50
                label = "\(name) DID SOMETHING GOOD!"
            } else if rand == 18 {
                power = 0
                label = "YOU COMMITTED SUICIDE!"
                self._hp = 0
            } else if rand > 7 {
                power = _attacks[name]! + 25
                label = "\(name) IS \(name)!"
            } else {
                power = 0
                label = "YOU ATTACKED THE WRONG ENEMY!"
            }
        }
        
        
        return (power, label)
    }
    
    func defense(damage: Int) {
        _hp -= damage
    }
    
    func resetHealth() {
        _hp = _fullHP
    }
    
    //Coin Adjustments
    func getCoins(enemy: String) {
        if enemy == "golem" {
            _coins += 10
        } else if enemy == "mouse" {
            _coins += 12
        } else if enemy == "pink snail" {
            _coins += 7
        } else if enemy == "blue snail" {
            _coins += 8
        } else if enemy == "mole" {
            _coins += 9
        } else if enemy == "rock boss" {
            _coins += 20
        }
    }
    
    func useCoins(price: Int) -> Bool {
        if price <= _coins {
            _coins -= price
            return true
        } else {
            return false
        }
    }
    
    //Loot Changes
    func increaseHealth(number: Int) {
        _fullHP += number
    }
    
    func increaseAttack(number: Int) {
        _attacks["BOULDER THROW"]! += number
        _attacks["BOOM BOOM"]! += number
        _attacks["ROAD SPIKES"]! += number
    }
}
//
//  Game.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation

class Game {
    
    private var _level: Int = 0
    private var _healthMultiplier: Int = 0
    private var _bonusLevel: Int = 0
    private var _enemyLevelUp: [Int] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    private var _highestLevel: Int = NSUserDefaults.standardUserDefaults().integerForKey("HighLevel")
    
    var level: Int {
        return _level
    }
    
    var healthMultiplier: Int {
        return _healthMultiplier
    }
    
    var bonusLevel: Int {
        return _bonusLevel
    }
    
    var highLevel: Int {
        return _highestLevel
    }
    
    func pickEnemy() -> (String) {
        let rand = arc4random_uniform(5)
        
        if rand == 0 {
            return "golem"
        } else if rand == 1 {
            return "mouse"
        } else if rand == 2 {
            return "pink snail"
        } else if rand == 3 {
            return "blue snail"
        } else if rand == 4 {
            return "mole"
        } else {
            return "golem"
        }
    }
    
    func updateLevel() {
        _level += 1
        if _level > highLevel {
            NSUserDefaults.standardUserDefaults().setInteger(_level, forKey: "HighLevel")
        }
    }
    
    func updateBonusLevel() {
        _bonusLevel += 1
    }
    
    func clearBonusLevel() {
        _bonusLevel = 0
    }
    
    func levelMultiplier() -> Double {
        let number = Double(_level) * 0.5
        
        return number
    }
    
    func updateHealthMultiplier() {
        for index in _enemyLevelUp {
            if _level == index {
                _healthMultiplier += 50
            }
        }
    }
    
}
//
//  GameVC.swift
//  Rawr 2
//
//  Created by James Dyer on 4/23/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import AVFoundation

class GameVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var georgeImg: CharacterImg!
    @IBOutlet weak var georgeInjuredImg: UIImageView!
    @IBOutlet weak var golemImg: CharacterImg!
    @IBOutlet weak var golemInjuredImg: UIImageView!
    @IBOutlet weak var blueSnailImg: CharacterImg!
    @IBOutlet weak var blueSnailInjuredImg: UIImageView!
    @IBOutlet weak var moleImg: CharacterImg!
    @IBOutlet weak var moleInjuredImg: UIImageView!
    @IBOutlet weak var mouseImg: CharacterImg!
    @IBOutlet weak var mouseInjuredImg: UIImageView!
    @IBOutlet weak var pinkSnailImg: CharacterImg!
    @IBOutlet weak var pinkSnailInjuredImg: UIImageView!
    @IBOutlet weak var enemyLbl: UILabel!
    @IBOutlet weak var enemyHPLbl: UILabel!
    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var playerHPLbl: UILabel!
    @IBOutlet weak var gameLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var attackBtns: UIStackView!
    @IBOutlet weak var nextLevelBtn: UIButton!
    @IBOutlet weak var nextLevelView: UIView!
    
    //Properties
    let game = Game()
    
    var george: Player!
    var golem: Golem? = Golem()
    var mouse: Mouse?
    var blueSnail: BlueSnail?
    var pinkSnail: PinkSnail?
    var mole: Mole?
    var currentEnemy: String!
    var enemyIsAlive: Bool = true
    var enemyHealthMultiplier: Int = 0
    var sfxInjured: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.updateLevel()
        
        do {
            
            try sfxInjured = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("etc_trash_bin", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music_timpani_error_05", ofType: "wav")!))
            
            sfxInjured.prepareToPlay()
            sfxDeath.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        george = Player(name: "george")
        setGame()
    }
    
    //Actions
    
    @IBAction func rockBtnPressed(sender: AnyObject) {
        let attack = "BOULDER THROW"
        gameTurn(attack)
    }
    
    @IBAction func dynamiteBtnPressed(sender: AnyObject) {
        let attack = "BOOM BOOM"
        gameTurn(attack)
    }
    
    @IBAction func spikeBtnPressed(sender: AnyObject) {
        let attack = "ROAD SPIKES"
        gameTurn(attack)
    }
    
    @IBAction func unknownBtnPressed(sender: AnyObject) {
        let attack = "UNKNOWN"
        gameTurn(attack)
    }
    
    @IBAction func nextLevelBtnPressed(sender: AnyObject) {
        game.updateLevel()
        levelLbl.text = "\(game.level)"
        game.updateBonusLevel()
        if game.bonusLevel == 5 {
            performSegueWithIdentifier("bonus", sender: george)
            game.clearBonusLevel()
        }
        setGame()
        enableBtns()
        nextLevelView.hidden = true
        nextLevelBtn.hidden = true
    }
    
    //METHODS
    
    //Resetting
    func setGame() {
        playerLbl.text = george.name
        george.resetHealth()
        //Double Enemy Health Every 10 Levels
        game.updateHealthMultiplier()
        georgeImg.startAnimating()
        playerHPLbl.text = "\(george.hp)"
        enemyIsAlive = true
        let enemy = game.pickEnemy()
        enemyStart(enemy)
        gameLbl.text = "THE \(enemy) HAS APPEARED"
    }
    
    func enemyStart(name: String) {
        currentEnemy = name
        clearEnemy()
        if name == "golem" {
            golemImg.hidden = false
            golemImg.imgAnimation(name, state: "idle", imgNum: 4)
            golem = Golem()
            golem!.increaseHealth(game.healthMultiplier)
            enemyLbl.text = golem!.name
            enemyHPLbl.text = "\(golem!.hp)"
        } else if name == "mouse" {
            mouseImg.hidden = false
            mouseImg.imgAnimation(name, state: "idle", imgNum: 4)
            mouse = Mouse()
            mouse!.increaseHealth(game.healthMultiplier)
            enemyLbl.text = mouse!.name
            enemyHPLbl.text = "\(mouse!.hp)"
        } else if name == "blue snail" {
            blueSnailImg.hidden = false
            blueSnailImg.imgAnimation(name, state: "idle", imgNum: 4)
            blueSnail = BlueSnail()
            blueSnail!.increaseHealth(game.healthMultiplier)
            enemyLbl.text = blueSnail!.name
            enemyHPLbl.text = "\(blueSnail!.hp)"
        } else if name == "pink snail" {
            pinkSnailImg.hidden = false
            pinkSnailImg.imgAnimation(name, state: "idle", imgNum: 4)
            pinkSnail = PinkSnail()
            pinkSnail!.increaseHealth(game.healthMultiplier)
            enemyLbl.text = pinkSnail!.name
            enemyHPLbl.text = "\(pinkSnail!.hp)"
        } else if name == "mole" {
            moleImg.hidden = false
            moleImg.imgAnimation(name, state: "idle", imgNum: 4)
            mole = Mole()
            mole!.increaseHealth(game.healthMultiplier)
            enemyLbl.text = mole!.name
            enemyHPLbl.text = "\(mole!.hp)"
        }
    }
    
    func clearEnemy() {
        golemImg.hidden = true
        mouseImg.hidden = true
        blueSnailImg.hidden = true
        pinkSnailImg.hidden = true
        moleImg.hidden = true
        golemImg.stopAnimating()
        blueSnailImg.stopAnimating()
        moleImg.stopAnimating()
        mouseImg.stopAnimating()
        pinkSnailImg.stopAnimating()
    }
    
    //Turns
    func gameTurn(attack: String) {
        disableBtns()
        playerAttack(attack)
        //Check If Player And Enemy Is Still Alive (Player Can Commit Suicide & Make Sure Enemy Does Not Attack When Dead)
        if george.hp > 0 && enemyIsAlive {
            playerHPLbl.text = "\(george.hp)"
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(enemyAttack), userInfo: nil, repeats: false)
        } else if george.hp <= 0 {
            playerDeath("SUICIDE")
        }
    }
    
    func clearLabels() {
        gameLbl.text = ""
        enableBtns()
    }
    
    func clearLabelTimer() {
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(clearLabels), userInfo: nil, repeats: false)
    }
    
    //Attacks
    func playerAttack(attack: String) {
        let georgeAttack = george.attack(attack)
        let power = georgeAttack.power
        let attackLabel = georgeAttack.label
        if currentEnemy == "golem" {
            //Run Attack
            golem!.defense(power)
            //Check If Enemy Is Alive
            if golem!.hp > 0 {
                gameLbl.text = attackLabel
                enemyHPLbl.text = "\(golem!.hp)"
                enemyInjured()
            } else {
                enemyDeath()
                golemImg.imgAnimation(currentEnemy, state: "dead", imgNum: 5)
            }
        } else if currentEnemy == "mouse" {
            mouse!.defense(power)
            if mouse!.hp > 0 {
                gameLbl.text = attackLabel
                enemyHPLbl.text = "\(mouse!.hp)"
                enemyInjured()
            } else {
                enemyDeath()
                mouseImg.imgAnimation(currentEnemy, state: "dead", imgNum: 4)
            }
        } else if currentEnemy == "blue snail" {
            blueSnail!.defense(power)
            if blueSnail!.hp > 0 {
                gameLbl.text = attackLabel
                enemyHPLbl.text = "\(blueSnail!.hp)"
                enemyInjured()
            } else {
                enemyDeath()
                blueSnailImg.imgAnimation(currentEnemy, state: "dead", imgNum: 3)
            }
        } else if currentEnemy == "pink snail" {
            pinkSnail!.defense(power)
            if pinkSnail!.hp > 0 {
                gameLbl.text = attackLabel
                enemyHPLbl.text = "\(pinkSnail!.hp)"
                enemyInjured()
            } else {
                enemyDeath()
                pinkSnailImg.imgAnimation(currentEnemy, state: "dead", imgNum: 3)
            }
        } else if currentEnemy == "mole" {
            mole!.defense(power)
            if mole!.hp > 0 {
                gameLbl.text = attackLabel
                enemyHPLbl.text = "\(mole!.hp)"
                enemyInjured()
            } else {
                enemyDeath()
                moleImg.imgAnimation(currentEnemy, state: "dead", imgNum: 6)
            }
        }
        
    }
    
    func enemyAttack() {
        let levelMultiplier = Int(ceil(game.levelMultiplier()))
        if currentEnemy == "golem" {
            //Run Attack
            let golemAttack = golem!.attack()
            let power = golemAttack.power * levelMultiplier
            let attackLabel = golemAttack.label
            george.defense(power)
            //Check If Player Is Alive
            if george.hp > 0 {
                playerInjured()
                gameLbl.text = attackLabel
                playerHPLbl.text = "\(george.hp)"
                enemyHPLbl.text = "\(golem!.hp)"
                clearLabelTimer()
            } else {
                playerDeath(nil)
            }
        } else if currentEnemy == "mouse" {
            let mouseAttack = mouse!.attack()
            let power = mouseAttack.power * levelMultiplier
            let attackLabel = mouseAttack.label
            george.defense(power)
            if george.hp > 0 {
                playerInjured()
                gameLbl.text = attackLabel
                playerHPLbl.text = "\(george.hp)"
                enemyHPLbl.text = "\(mouse!.hp)"
                clearLabelTimer()
            } else {
                playerDeath(nil)
            }
        } else if currentEnemy == "blue snail" {
            let blueSnailAttack = blueSnail!.attack()
            let power = blueSnailAttack.power * levelMultiplier
            let attackLabel = blueSnailAttack.label
            george.defense(power)
            if george.hp > 0 {
                playerInjured()
                gameLbl.text = attackLabel
                playerHPLbl.text = "\(george.hp)"
                enemyHPLbl.text = "\(blueSnail!.hp)"
                clearLabelTimer()
            } else {
                playerDeath(nil)
            }
        } else if currentEnemy == "pink snail" {
            let pinkSnailAttack = pinkSnail!.attack()
            let power = pinkSnailAttack.power * levelMultiplier
            let attackLabel = pinkSnailAttack.label
            george.defense(power)
            if george.hp > 0 {
                playerInjured()
                gameLbl.text = attackLabel
                playerHPLbl.text = "\(george.hp)"
                enemyHPLbl.text = "\(pinkSnail!.hp)"
                clearLabelTimer()
            } else {
                playerDeath(nil)
            }
        } else if currentEnemy == "mole" {
            let moleAttack = mole!.attack()
            let power = moleAttack.power * levelMultiplier
            let attackLabel = moleAttack.label
            george.defense(power)
            if george.hp > 0 {
                playerInjured()
                gameLbl.text = attackLabel
                playerHPLbl.text = "\(george.hp)"
                enemyHPLbl.text = "\(mole!.hp)"
                if mole!.hp <= 0 {
                    enemyDeath()
                    moleImg.imgAnimation(currentEnemy, state: "dead", imgNum: 6)
                } else {
                   clearLabelTimer()
                }
            } else {
                playerDeath(nil)
            }
        }
    }
    
    //Injuries
    func enemyInjured() {
        playInjuredSound()
        if currentEnemy == "golem" {
            golemInjuredImg.hidden = false
        } else if currentEnemy == "mouse" {
            mouseInjuredImg.hidden = false
        } else if currentEnemy == "blue snail" {
            blueSnailInjuredImg.hidden = false
        } else if currentEnemy == "pink snail" {
            pinkSnailInjuredImg.hidden = false
        } else if currentEnemy == "mole" {
            moleInjuredImg.hidden = false
        }
        injuryTimer()
    }
    
    func playerInjured() {
        playInjuredSound()
        georgeInjuredImg.hidden = false
        injuryTimer()
    }
    
    func hideInjured() {
        georgeInjuredImg.hidden = true
        golemInjuredImg.hidden = true
        mouseInjuredImg.hidden = true
        blueSnailInjuredImg.hidden = true
        pinkSnailInjuredImg.hidden = true
        moleInjuredImg.hidden = true
    }
    
    func injuryTimer() {
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(hideInjured), userInfo: nil, repeats: false)
    }
    
    //Deaths
    func enemyDeath() {
        playDeathSound()
        enemyIsAlive = false
        enemyHPLbl.text = "0"
        gameLbl.text = "YOU KILLED THE \(currentEnemy)!"
        disableBtns()
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(lootStore), userInfo: nil, repeats: false)
    }
    
    func playerDeath(type: String?) {
        playDeathSound()
        playerHPLbl.text = "0"
        if type != "SUICIDE" {
            gameLbl.text = "YOU WERE KILLED!"
        }
        disableBtns()
        georgeImg.imgAnimation("george", state: "dead", imgNum: 5)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(diedScreen), userInfo: nil, repeats: false)
    }
    
    //Controlling Buttons
    func disableBtns() {
        attackBtns.userInteractionEnabled = false
        attackBtns.alpha = 0.6
    }
    
    func enableBtns() {
        attackBtns.userInteractionEnabled = true
        attackBtns.alpha = 1.0
    }
    
    //Sharing Player Instance
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "lootStore" {
            if let storeVC = segue.destinationViewController as? StoreVC {
                if let george = sender as? Player {
                    storeVC.george = george
                }
            }
        } else if segue.identifier == "bonus" {
            if let bossVC = segue.destinationViewController as? BossVC {
                if let george = sender as? Player {
                    bossVC.george = george
                }
            }
        }
    }
    
    //Next Screens
    func lootStore() {
        george.getCoins(currentEnemy)
        performSegueWithIdentifier("lootStore", sender: george)
        nextLevelView.hidden = false
        nextLevelBtn.hidden = false
    }
    
    func diedScreen() {
        performSegueWithIdentifier("died", sender: nil)
    }
    
    //Sound Effects
    func playInjuredSound() {
        if sfxInjured.playing {
            sfxInjured.stop()
        }
        
        sfxInjured.play()
    }
    
    func playDeathSound() {
        if sfxDeath.playing {
            sfxDeath.stop()
        }
        
        sfxDeath.play()
    }

}

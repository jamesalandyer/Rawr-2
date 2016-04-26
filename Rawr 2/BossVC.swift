//
//  BossVC.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import AVFoundation

class BossVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var rockBossImg: CharacterImg!
    @IBOutlet weak var game1WinnerImg: UIImageView!
    @IBOutlet weak var game2WinnerImg: UIImageView!
    @IBOutlet weak var game3WinnerImg: UIImageView!
    @IBOutlet weak var game4WinnerImg: UIImageView!
    @IBOutlet weak var game5WinnerImg: UIImageView!
    @IBOutlet weak var gameLbl: UILabel!
    @IBOutlet weak var choiceBtns: UIStackView!
    
    //Properties
    let enemyName: String = "rock boss"
    let choice1: String = "hammer"
    let choice2: String = "box cutter"
    let choice3: String = "hard hat"
    
    var george: Player!
    var playerChoice: String!
    var roundWinner: String!
    var playerWins: Int = 0
    var enemyWins: Int = 0
    var round: Int {
        return playerWins + enemyWins
    }
    var label: String!
    var sfxWin: AVAudioPlayer!
    var sfxBtn: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rockBossImg.imgAnimation(enemyName, state: "idle", imgNum: 4)
        
        do {
            
            try sfxWin = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music_vibelong_chord_up", ofType: "wav")!))
            try sfxBtn = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pop_digi", ofType: "wav")!))
            
            sfxWin.prepareToPlay()
            sfxBtn.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //Actions
    @IBAction func hammerBtnPressed(sender: AnyObject) {
        playBtnSound()
        disableBtns()
        playerChoice = choice1
        let enemy = enemyChoice()
        runRound(playerChoice, enemy: enemy)
    }
    
    @IBAction func boxCutterPressed(sender: AnyObject) {
        playBtnSound()
        disableBtns()
        playerChoice = choice2
        let enemy = enemyChoice()
        runRound(playerChoice, enemy: enemy)
    }
    
    @IBAction func hardHatPressed(sender: AnyObject) {
        playBtnSound()
        disableBtns()
        playerChoice = choice3
        let enemy = enemyChoice()
        runRound(playerChoice, enemy: enemy)
    }
    
    //METHODS
    
    //Enemy Choice
    func enemyChoice() -> String {
        let rand = arc4random_uniform(3)
        
        if rand == 0 {
            return choice1
        } else if rand == 1 {
            return choice2
        } else {
            return choice3
        }
    }
    
    //Process Choices
    func runRound(player: String, enemy: String) {
        if player == choice1 && enemy == choice2 {
            roundWinner = "george"
            label = "YOUR \(player) SMASHED HIS \(enemy)"
        } else if player == choice1 && enemy == choice3 {
            roundWinner = enemyName
            label = "HIS \(enemy) BROKE YOUR \(player)"
        } else if player == choice2 && enemy == choice1 {
            roundWinner = enemyName
            label = "HIS \(enemy) SMASHED YOUR \(player)"
        } else if player == choice2 && enemy == choice3 {
            roundWinner = "george"
            label = "YOUR \(player) CUT UP HIS \(enemy)"
        } else if player == choice3 && enemy == choice2 {
            roundWinner = enemyName
            label = "HIS \(enemy) CUT UP YOUR \(player)"
        } else if player == choice3 && enemy == choice1 {
            roundWinner = "george"
            label = "YOUR \(player) BROKE HIS \(enemy)"
        } else {
            roundWinner = "draw"
            label = "You both selected \(player)"
        }
        updateRound()
    }
    
    //Update Game
    func updateRound() {
        gameLbl.text = label
        if roundWinner == "george" {
            playWinSound()
            playerWins += 1
            updateTimer()
        } else if roundWinner == enemyName {
            enemyWins += 1
            updateTimer()
        } else {
            enableBtns()
        }
    }
    
    func updateTimer() {
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(updateGame), userInfo: nil, repeats: false)
    }
    
    func updateGame() {
        if round == 1 {
            game1WinnerImg.image = UIImage(named: "\(roundWinner)idle1.png")
        } else if round == 2 {
            game2WinnerImg.image = UIImage(named: "\(roundWinner)idle1.png")
        } else if round == 3 {
            game3WinnerImg.image = UIImage(named: "\(roundWinner)idle1.png")
        } else if round == 4 {
            game4WinnerImg.image = UIImage(named: "\(roundWinner)idle1.png")
        } else if round == 5 {
            game5WinnerImg.image = UIImage(named: "\(roundWinner)idle1.png")
        }
        gameLbl.text = "\(roundWinner) WON THE ROUND!"
        if noWinner() {
            enableBtns()
        }
    }
    
    func noWinner() -> Bool {
        if playerWins >= 3 {
            getBonus(true)
            return false
        } else if enemyWins >= 3 {
            getBonus(false)
            return false
        }
        
        return true
    }
    
    //Controlling Buttons
    func disableBtns() {
        choiceBtns.userInteractionEnabled = false
        choiceBtns.alpha = 0.6
    }
    
    func enableBtns() {
        choiceBtns.userInteractionEnabled = true
        choiceBtns.alpha = 1.0
    }
    
    //End Game
    func getBonus(val: Bool) {
        if val {
            rockBossImg.imgAnimation(enemyName, state: "dead", imgNum: 5)
            gameLbl.text = "YOU WON 20 COINS"
            george.getCoins(enemyName)
        } else {
            gameLbl.text = "YOU LOST"
        }
        
        NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)
    }
    
    func gameOver() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Sound Effects
    func playWinSound() {
        if sfxWin.playing {
            sfxWin.stop()
        }
        
        sfxWin.play()
    }
    
    func playBtnSound() {
        if sfxBtn.playing {
            sfxBtn.stop()
        }
        
        sfxBtn.play()
    }

}

//
//  StoreVC.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import AVFoundation

class StoreVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var currentDescLbl: UILabel!
    @IBOutlet weak var currentCoinsLbl: UILabel!
    @IBOutlet weak var berryBarBtn: CustomButton!
    @IBOutlet weak var axePressBtn: CustomButton!
    @IBOutlet weak var rockSuitBtn: CustomButton!
    @IBOutlet weak var diamondsBtn: CustomButton!
    
    //Properties
    var george: Player!
    var sfxBought: AVAudioPlayer!
    var sfxDenied: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            try sfxBought = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("digi_welcome", ofType: "wav")!))
            try sfxDenied = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("digi_warn", ofType: "wav")!))
            
            sfxBought.prepareToPlay()
            sfxDenied.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        currentCoinsLbl.text = "\(george.coins)"
    }
    
    //Actions
    @IBAction func berryBarPressed(sender: AnyObject) {
        if george.useCoins(10) {
            purchase()
            george.increaseHealth(10)
        } else {
            changeLbl()
        }
    }
    
    @IBAction func axePressPressed(sender: AnyObject) {
        if george.useCoins(10) {
            purchase()
            george.increaseAttack(10)
        } else {
            changeLbl()
        }
    }
    
    @IBAction func rockSuitPressed(sender: AnyObject) {
        if george.useCoins(50) {
            purchase()
            george.increaseHealth(60)
        } else {
            changeLbl()
        }
    }
    
    @IBAction func diamondsPressed(sender: AnyObject) {
        if george.useCoins(100) {
            purchase()
            george.increaseHealth(60)
            george.increaseAttack(50)
        } else {
            changeLbl()
        }
    }
    
    @IBAction func continueBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //METHODS
    
    //Adjusting Coin Label
    func purchase() {
        playSucessSound()
        currentDescLbl.textColor = UIColor.greenColor()
        currentCoinsLbl.textColor = UIColor.greenColor()
        currentCoinsLbl.text = "\(george.coins)"
        timer()
    }
    
    func timer() {
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(revertLbl), userInfo: nil, repeats: false)
    }
    
    func changeLbl() {
        playDeniedSound()
        currentDescLbl.textColor = UIColor.redColor()
        currentCoinsLbl.textColor = UIColor.redColor()
        timer()
    }
    
    func revertLbl() {
        currentDescLbl.textColor = UIColor.whiteColor()
        currentCoinsLbl.textColor = UIColor.whiteColor()
    }
    
    //Sound Effects
    func playSucessSound() {
        if sfxBought.playing {
            sfxBought.stop()
        }
        
        sfxBought.play()
    }
    
    func playDeniedSound() {
        if sfxDenied.playing {
            sfxDenied.stop()
        }
        
        sfxDenied.play()
    }
}

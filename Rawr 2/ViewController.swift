//
//  ViewController.swift
//  Rawr 2
//
//  Created by James Dyer on 4/23/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var musicPlayer: AVAudioPlayer!

    @IBOutlet weak var highLevelLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            musicPlayer.volume = 0.5
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        highLevelLbl.text = "\(Game().highLevel)"
    }


}


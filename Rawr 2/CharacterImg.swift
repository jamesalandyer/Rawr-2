//
//  CharacterImg.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit

class CharacterImg: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imgAnimation("george", state: "idle", imgNum: 4)
    }
    
    func imgAnimation(name: String, state: String, imgNum: Int) {
        if state == "idle" {
            self.image = UIImage(named: "\(name)\(state)1.png")
        } else {
            self.image = UIImage(named: "\(name)\(state)\(imgNum).png")
        }
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for index in 1...imgNum {
            let img = UIImage(named: "\(name)\(state)\(index).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        if state == "dead" {
            self.animationRepeatCount = 1
            self.startAnimating()
        } else {
            self.animationRepeatCount = 0
            self.startAnimating()
        }
        
        
    }

}

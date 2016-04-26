//
//  GradientButton.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import Foundation

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        layer.cornerRadius = 10.0
        let background = CAGradientLayer().orangeColor()
        self.layer.insertSublayer(background, atIndex: 0)
        background.frame = self.layer.bounds
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.whiteColor().CGColor
    }

}

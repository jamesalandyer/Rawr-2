//
//  CAGradientLayer.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func orangeColor() -> CAGradientLayer {
        
        let topColor = UIColor(red: 250/255.0, green: 217/255.0, blue: 97/255.0, alpha: 1)
        let bottomColor = UIColor(red: 247/255.0, green: 107/255.0, blue: 28/255.0, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}

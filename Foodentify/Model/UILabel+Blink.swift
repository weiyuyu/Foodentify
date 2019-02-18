//
//  UILabel+Blink.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/6/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func startBlink() {
        UIView.animate(withDuration: 0.8,
                       delay:0.0,
                       options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.alpha = 0 },
                       completion: nil)
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

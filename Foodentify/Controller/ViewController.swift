//
//  ViewController.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/1/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var FoodentifyTitle: UILabel!
    @IBOutlet weak var HintMessage: UILabel!
    @IBOutlet weak var FoodentifyButton: UIButton!
    @IBOutlet weak var FoodentifyImage: UIImageView!
    
    var pulsatingLayer : CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.fillColor = UIColor.yellow.cgColor
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round
        pulsatingLayer.position = view.center
        pulsatingLayer.zPosition = -1000
        view.layer.addSublayer(pulsatingLayer)
        
        animatePulsatingLayer()
        
        self.rotateView(targetView: FoodentifyImage)
        
        print("Blink Start")
        HintMessage.startBlink()
    }
    
    func rotateView(targetView: UIView, duration: Double = 2.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotateView(targetView: self.FoodentifyImage, duration: duration)
        }
    }
    
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.35
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
}


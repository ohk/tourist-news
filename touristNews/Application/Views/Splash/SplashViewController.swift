//
//  SplashViewController.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/27/22.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    private let vm = SplashViewModel()
    private let gradient = CAGradientLayer()
    private let appLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateGradient()
        addLabel()
    }
    
    private func animateGradient() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.gradient.frame = self.view.frame
            self.gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            self.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            self.gradient.colors = [
                UIColor.white.cgColor,
                UIColor(named: "SoftPrimary")?.cgColor ?? UIColor.white.cgColor,
                UIColor(named: "Primary")?.cgColor ?? UIColor.white.cgColor
            ]
            
            self.gradient.locations =  [1, 0.5, 0, 0.5, 1.5]
            
            let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
            
            animation.fromValue = [
                UIColor(named: "SoftPrimary")?.cgColor  ?? UIColor.white.cgColor,
                UIColor(named: "SoftPrimary")?.cgColor  ?? UIColor.white.cgColor,
                UIColor(named: "Primary")?.cgColor  ?? UIColor.white.cgColor
            ]
            
            animation.toValue = [
                UIColor(named: "Primary")?.cgColor  ?? UIColor.white.cgColor,
                UIColor(named: "SoftPrimary")?.cgColor ?? UIColor.white.cgColor,
                UIColor(named: "Primary")?.cgColor ?? UIColor.white.cgColor
            ]
            
            animation.duration = 1
            animation.autoreverses = true
            animation.repeatCount = .infinity
            
            self.gradient.add(animation, forKey: nil)
            self.view.layer.insertSublayer(self.gradient, at: 0)
        }
    }
    
    private func addLabel() {
        appLabel.text = vm.appLabel
        appLabel.font = appLabel.font.withSize(30)
        appLabel.numberOfLines = 0
        appLabel.textAlignment = .center
        appLabel.sizeToFit()
        appLabel.textColor = .white
        appLabel.center = self.view.center
        self.view.addSubview(appLabel)
    }
}

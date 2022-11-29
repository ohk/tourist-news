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
        checkConnection()
    }
    
    func checkConnection(){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            if NetworkMonitor.shared.isConnected {
                Logger.shared.addLog(message: "Connected to network. App should be start")
                self.startApp()
            } else {
                self.showNativeAlertWith(
                    message: "There seems to be a problem with your internet connection. The news and users you will see may not reflect the updated data. Please check your internet connection.",
                    positiveAction: UIAlertAction(title: "Open The App", style: .cancel, handler: { (action) in
                        self.startApp()
                        Logger.shared.addLog(message: "User open the app without connection")
                    }),
                    negativeAction: UIAlertAction(title: "Close The App", style: .destructive, handler: { (action) in
                        Logger.shared.addLog(message: "User close the app")
                        exit(-1)
                    })
                )
            }
        }
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
    
    func startApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let self = self else { return }
            self.navigateTo(vc: .Home)
        })
    }
}

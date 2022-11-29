//
//  NavigationHandler.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/27/22.
//

import Foundation
import UIKit

enum PagesEnum {
    case Home
}

extension UIViewController {
    
    private func pageFinder(vc: PagesEnum, externalData: Any?) -> UIViewController {
        switch vc {
        case .Home:
            return HomeViewController()
        }
    }
    
    func navigateTo(vc: PagesEnum, style: UIModalPresentationStyle? = .overFullScreen, externalData: Any? = nil) {
        let vc: UIViewController = pageFinder(vc: vc, externalData: externalData)
        let nav: UINavigationController = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = style ?? .overFullScreen
        self.present(nav,animated: true,completion: nil)
    }
}

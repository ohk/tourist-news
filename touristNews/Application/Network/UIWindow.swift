//
//  UIWindow.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/28/22.
//

import Foundation
import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}


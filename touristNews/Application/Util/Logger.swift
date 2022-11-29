//
//  Logger.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/28/22.
//

import Foundation

class Logger {
    static let shared = Logger()
    
    func addLog(message: String, always: Bool? = false) {
        #if DEBUG
        print("TN: \(message)")
        #else
        if always == false {
            //HANDLE LATER
            print("TN - UNHANDLED LOG: " + message)
        } else {
            print("TN: \(message)")
        }
        #endif
    }
}

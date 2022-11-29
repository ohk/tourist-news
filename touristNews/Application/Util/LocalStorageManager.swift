//
//  LocalStorageManager.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation

class AppStorage {
    public static let userDefaults =  UserDefaults.standard
    
    static func writeAnyData<T:Codable>(key: String, value: T){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(value)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    static func readData<T:Codable>(key: String, type: T.Type) -> T? {
        if userDefaults.object(forKey: key) == nil {
            return nil
        } else {
            let decoder = JSONDecoder()
            let data = userDefaults.data(forKey: key)
            do {
                if let fData = data {
                    let idata = try decoder.decode(T.self, from: fData)
                    return idata
                }
                return nil
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }
}

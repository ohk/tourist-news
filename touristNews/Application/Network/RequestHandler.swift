//
//  RequestHandler.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation
import Alamofire

class RequestHandler {
    public static let shared = RequestHandler()
    
    func getRequest<T: Codable>(url: String, model: T.Type, completion: @escaping (T?) -> ()){
        Logger.shared.addLog(message: "GET REQUEST - URL: \(url)")
        ApplicationLoader.shared.start()
        let storedValue = AppStorage.readData(key: url, type: model)
        
        if NetworkMonitor.shared.isConnected  {
            let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            
            request.responseDecodable(of: model.self) { (response) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    ApplicationLoader.shared.dismiss()
                })
                //debugPrint(response)
                guard let response = response.value else {
                    completion(nil)
                    return
                }
                Logger.shared.addLog(message: "unstored")
                AppStorage.writeAnyData(key: url, value: response)
                completion(response)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                ApplicationLoader.shared.dismiss()
            })
            if(storedValue != nil) {
                completion(storedValue)
                Logger.shared.addLog(message: "stored")
            } else {
                completion(nil)
            }
        }
    }
}

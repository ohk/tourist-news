//
//  UsersModel.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation

// MARK: - UsersModel
struct UsersModel: Codable {
    let page, perPage, totalrecord, totalPages: Int
    let data: [UsersModelData]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalrecord
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - UserData
struct UsersModelData: Codable {
    let id: Int
    let touristName, touristEmail, touristLocation, createdat: String

    enum CodingKeys: String, CodingKey {
        case id
        case touristName = "tourist_name"
        case touristEmail = "tourist_email"
        case touristLocation = "tourist_location"
        case createdat
    }
}

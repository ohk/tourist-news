//
//  NewsModel.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let page, perPage, totalrecord, totalPages: Int
    let data: [NewsModelData]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalrecord
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - NewsModelData
struct NewsModelData: Codable {
    let id: Int
    let title, description: String?
    let location: String
    let multiMedia: [MultiMedia]
    let createdat: String
    let user: User
    let commentCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, description,location, multiMedia, createdat, user, commentCount
    }
}

// MARK: - MultiMedia
struct MultiMedia: Codable {
    let id: Int
    let name: String
    let url: String
    let createat: String

    enum CodingKeys: String, CodingKey {
        case id, name, url, createat
    }
}

// MARK: - User
struct User: Codable {
    let userid: Int
    let name: String
    let profilepicture: String
    
    enum CodingKeys: String, CodingKey {
        case userid, name, profilepicture
    }
}

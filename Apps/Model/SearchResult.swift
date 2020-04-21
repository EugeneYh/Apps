//
//  SearchData.swift
//  Apps
//
//  Created by Eugene on 07.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    var screenshotUrls: [String]?
    let artworkUrl100: String
    var formattedPrice: String?
    var description: String?
    var releaseNotes: String?
    var artistName: String?
    var collectionName: String?
}

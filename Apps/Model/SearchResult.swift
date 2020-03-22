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
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}

//
//  AppsGroup.swift
//  Apps
//
//  Created by Eugene on 18.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation

class AppsGroup: Decodable {
    let feed: Feed
}

class Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

class FeedResult: Decodable {
    let id, artistName, name, artworkUrl100: String
}

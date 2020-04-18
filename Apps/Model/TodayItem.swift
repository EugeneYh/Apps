//
//  TodayItem.swift
//  Apps
//
//  Created by Eugene on 01.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

struct TodayItem {
    let categoryLabel: String
    let titleLabel: String
    let imageView: UIImage
    let descriprionLabel: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}

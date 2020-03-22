//
//  HorizontalsnappinController.swift
//  Apps
//
//  Created by Eugene on 22.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class HorizontalsnappinController: UICollectionViewController {
    init() {
        let layout = SnappingLauout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        self.collectionView.decelerationRate = .fast
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  ScreenshotsController.swift
//  Apps
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappinController, UICollectionViewDelegateFlowLayout {
    
    let screenshotsCellId = "screenshotsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: screenshotsCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotsCellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

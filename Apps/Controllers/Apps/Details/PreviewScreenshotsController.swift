//
//  ScreenshotsController.swift
//  Apps
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappinController, UICollectionViewDelegateFlowLayout {
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    let screenshotsCellId = "screenshotsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(PreviewScreenshotsCell.self, forCellWithReuseIdentifier: screenshotsCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls!.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotsCellId, for: indexPath) as! PreviewScreenshotsCell
        cell.imageView.sd_setImage(with: URL(string: app?.screenshotUrls?[indexPath.item] ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

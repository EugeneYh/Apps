//
//  AppHeaderHorizontalController.swift
//  Apps
//
//  Created by Eugene on 14.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappinController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var apps = [SocialApps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        let appsInfo = apps[indexPath.item]
        cell.appName.text = appsInfo.name
        cell.appDescription.text = appsInfo.tagline
        cell.imageView.sd_setImage(with: URL(string: appsInfo.imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
}

//
//  AppsHorizontalController.swift
//  Apps
//
//  Created by Eugene on 12.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappinController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let topAndBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    var appsGroup: AppsGroup?
    var didSelectHandler: ((FeedResult)-> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsRowCell
        let appsInfo = appsGroup?.feed.results[indexPath.item]
        cell.companyLabel.text = appsInfo?.artistName
        cell.nameLabel.text = appsInfo?.name
        cell.imageView.sd_setImage(with: URL(string: appsInfo?.artworkUrl100 ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topAndBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appsGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
        
    }
    
}

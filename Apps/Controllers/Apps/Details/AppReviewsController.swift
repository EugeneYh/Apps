//
//  AppReviewsController.swift
//  Apps
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppReviewsController: HorizontalSnappinController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var reviews: Reviews? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
        let entry = self.reviews?.feed.entry[indexPath.item]
        cell.authorLabel.text = entry?.author.name.label
        cell.titleLabel.text = entry?.title.label
        cell.bodyLabel.text = entry?.content.label
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    
}

//
//  AppDetailsController.swift
//  Apps
//
//  Created by Eugene on 23.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let detailsCellId = "detailsCellId"
    let previewCellId = "previewCellId"
    let reviewsCellId = "reviewsCellId"
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?l=en&cc=us"
            Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
                if let error = error {
                    print("Failed to decode reviews: ", error)
                    return
                }
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    var reviews: Reviews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppsDetailCell.self, forCellWithReuseIdentifier: detailsCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewsCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCellId, for: indexPath) as! AppsDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as! ReviewRowCell
            cell.horizontalController.reviews = self.reviews
            return cell
        }
    }
    
    // MARK: setup the dynamic cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let dummyCell = AppsDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        } else {
            return .init(width: view.frame.width, height: 280)
        }
    }
    
}

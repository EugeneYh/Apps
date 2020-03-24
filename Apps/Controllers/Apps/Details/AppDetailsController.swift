//
//  AppDetailsController.swift
//  Apps
//
//  Created by Eugene on 23.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppDetailsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var appId: String! {
        didSet {
            if let appId = appId {
                let urrString = "https://itunes.apple.com/lookup?id=\(appId)"
                Service.shared.fetchGenericJSONData(urlString: urrString) { (result: SearchResult?, error) in
                    print(result?.results.first?.releaseNotes)
                }
                print("The app ID is: ", appId)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppsDetailCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsDetailCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
}

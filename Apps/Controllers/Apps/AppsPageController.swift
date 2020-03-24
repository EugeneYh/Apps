//
//  AppsController.swift
//  Apps
//
//  Created by Eugene on 09.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "celId"
    let headerId = "headerId"
    //var appsGroupResults: AppsGroup?
    var groups = [AppsGroup]()
    var socailApps = [SocialApps]()
    
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .blue
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        fetchData()
    }
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchAppsWeLove { (appsGroup, error) in
            dispatchGroup.leave()
            if let appsGroup = appsGroup {
                self.groups.append(appsGroup)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGamesWeLove { (appsGroup, error) in
            dispatchGroup.leave()
            if let appsGroup = appsGroup {
                self.groups.append(appsGroup)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { (appsGroup, error) in
            dispatchGroup.leave()
            if let appsGroup = appsGroup {
                self.groups.append(appsGroup)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (socialApps, error) in
            dispatchGroup.leave()
            self.socailApps = socialApps ?? []
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Copleted your dispatch gruop task")
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.apps = self.socailApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appsGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        
        cell.horizontalController.didSelectHandler = { [weak self] app in
            let appDetailsController = AppDetailsController()
            appDetailsController.appId = app.id
            appDetailsController.navigationItem.title = app.name
            self?.navigationController?.pushViewController(appDetailsController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}

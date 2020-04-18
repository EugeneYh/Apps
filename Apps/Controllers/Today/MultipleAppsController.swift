//
//  MultipleCellController.swift
//  Apps
//
//  Created by Eugene on 07.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class MultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "celld"
    let linespacing: CGFloat = 15
    var apps = [FeedResult]()
    let cellHeight: CGFloat = 70
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(closeButtonClickAction), for: .touchUpInside)
        return button
    }()
    
    override var prefersStatusBarHidden: Bool {return true}
    
    
    fileprivate var mode: Mode
    
    enum Mode: String {
        case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: cellId)
        if mode == .fullscreen {
            setupView()
            navigationController?.navigationBar.isHidden = true
        } else {
            collectionView.isScrollEnabled = false
        }
    }
    
    @objc fileprivate func closeButtonClickAction() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupView() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 36, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return min(4, apps.count)
        }
        return apps.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppsCell
        cell.item = apps[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = self.apps[indexPath.item].id
        let appViewController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if mode == .small {
            let height = (view.frame.height - (3 * linespacing)) / 4
            return .init(width: view.frame.width, height: height)
        }
        return .init(width: view.frame.width - 44, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 16, left: 20, bottom: 16, right: 20)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return linespacing
    }
    
    
    
}


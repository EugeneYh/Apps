//
//  TodayController.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var startingFrame: CGRect?
    var fullScreenViewController: TodayFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var anchoredConsraints: AnchoredConstraints?
    var gamesWeLove: AppsGroup?
    var appsWeLove: AppsGroup?
    var items = [TodayItem]()
    var appFullScreenBeginOffset: CGFloat = 0
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    static let cellHeight: CGFloat = 500
    
    let activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.color = .darkGray
        av.hidesWhenStopped = true
        av.style = .large
        av.startAnimating()
        return av
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        fetchApps()
        view.addSubview(activityIndicator)
        view.addSubview(blurEffectView)
        activityIndicator.centerInSuperview()
        blurEffectView.fillSuperview()
        blurEffectView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchApps() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchAppsWeLove { (appsResult, error) in
            dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch AppsWeLove: ", error)
                return
            }
            if let appsResult = appsResult {
                self.appsWeLove = appsResult
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGamesWeLove { (appsResult, error) in
            dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch GamesWeLove: ", error)
                return
            }
            if let appsResult = appsResult {
                self.gamesWeLove = appsResult
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            
            self.items = [
                TodayItem(categoryLabel: "LIFE HACK", titleLabel: "Utilizing your Time", imageView: #imageLiteral(resourceName: "garden"), descriprionLabel: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem(categoryLabel: "Daily List", titleLabel: self.gamesWeLove?.feed.title ?? "", imageView: #imageLiteral(resourceName: "garden"), descriprionLabel: "", backgroundColor: .white, cellType: .multiple, apps: self.gamesWeLove?.feed.results ?? []),
                TodayItem(categoryLabel: "Daily List", titleLabel: self.appsWeLove?.feed.title ?? "", imageView: #imageLiteral(resourceName: "garden"), descriprionLabel: "All the tools and apps you need to intellygently organize your life the right way", backgroundColor: .white, cellType: .multiple, apps: self.appsWeLove?.feed.results ?? []),
                TodayItem(categoryLabel: "HOLIDAYS", titleLabel: "Travel on a Budget", imageView: #imageLiteral(resourceName: "holiday"), descriprionLabel: "Find out all you need to know on how to travel without packing everything", backgroundColor: #colorLiteral(red: 0.9824687839, green: 0.9656403661, blue: 0.7212557197, alpha: 1), cellType: .single, apps: [])
            ]
        }
    }
    
    fileprivate func showDailyListFullscreen(_ indexPath: IndexPath) {
        let fullscreenController = MultipleAppsController(mode: .fullscreen)
        let navController = UINavigationController(rootViewController: fullscreenController)
        navController.modalPresentationStyle = .fullScreen
        fullscreenController.apps = self.items[indexPath.item].apps
        present(navController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullscreen(indexPath)
        default:
            showSingleAppFullscreen(indexPath: indexPath)
        }
    }
    
    fileprivate func setupSingleAppFullcreenController(_ indexPath: IndexPath) {
        let todayFullscreenController = TodayFullScreenController()
        todayFullscreenController.todayItem = items[indexPath.row]
        todayFullscreenController.dismissHandler = {
            self.handleAppFullscreenDismissal()
        }
        self.fullScreenViewController = todayFullscreenController
        todayFullscreenController.view.layer.cornerRadius = 16
        
        // #1 - setup pan gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        todayFullscreenController.view.addGestureRecognizer(gesture)
        
        
        // #2 - add a blur effect view
        
        
        // #3 - avoid affecting of the tableView scrolling
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began {
            appFullScreenBeginOffset = fullScreenViewController.tableView.contentOffset.y
        }
        
        if fullScreenViewController.tableView.contentOffset.y > 0 {
            return
        }
        
        let translationY = gesture.translation(in: fullScreenViewController.view).y
        
        if gesture.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - appFullScreenBeginOffset
                
                var scale = 1 - trueOffset / 500
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.fullScreenViewController.view.transform = transform
            }
        }
        
        if gesture.state == .ended {
            if translationY > 0 {
                handleAppFullscreenDismissal()
            }
        }
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        // absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        
        let fullScreenView = fullScreenViewController.view!
        
        view.addSubview(fullScreenView)
        addChild(fullScreenViewController)
        setupStartingCellFrame(indexPath)
       
        guard let startingFrame = self.startingFrame else {return}
        
        self.anchoredConsraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func beginAppFullscreenAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConsraints?.top?.constant = 0
            self.anchoredConsraints?.leading?.constant = 0
            self.anchoredConsraints?.height?.constant = self.view.frame.height
            self.anchoredConsraints?.width?.constant = self.view.frame.width

            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.origin.y + self.view.frame.size.height
           
            guard let cell = self.fullScreenViewController.tableView.cellForRow(at: [0,0]) as? TodayFullscreenHeaderCell else {return}
            cell.todayCell.topConstraint.constant = 44
            self.blurEffectView.alpha = 1
       })
    }
    
    fileprivate func showSingleAppFullscreen(indexPath: IndexPath) {
        self.collectionView.isUserInteractionEnabled = false
        // #1
        setupSingleAppFullcreenController(indexPath)
         
        // #2 setup fullscreen in its starting position
        setupAppFullscreenStartingPosition(indexPath)
        
        // #3 begin the fullscreen animation
        beginAppFullscreenAnimation()
    }
    
    
    @objc func handleAppFullscreenDismissal() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.fullScreenViewController.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else {return}
            self.anchoredConsraints?.top?.constant = startingFrame.origin.y
            self.anchoredConsraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConsraints?.width?.constant = startingFrame.width
            self.anchoredConsraints?.height?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            self.fullScreenViewController.view.transform = .identity
            
            self.tabBarController?.tabBar.transform = .identity
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
            guard let cell = self.fullScreenViewController.tableView.cellForRow(at: [0,0]) as? TodayFullscreenHeaderCell else {return}
            //cell.closeButton.alpha = 0
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
            
        }, completion: {_ in
            self.fullScreenViewController.view.removeFromSuperview()
            self.fullScreenViewController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
            self.blurEffectView.alpha = 0
        })
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.row].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.row]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppTap)))
        return cell
    }
    
    @objc fileprivate func handleMultipleAppTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                let apps = self.items[indexPath.item].apps
                let fullscreenController = MultipleAppsController(mode: .fullscreen)
                let navController = UINavigationController(rootViewController: fullscreenController)
                navController.modalPresentationStyle = .fullScreen
                fullscreenController.apps = apps
                present(navController, animated: true)
                return
            }
            superView = superView?.superview
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}

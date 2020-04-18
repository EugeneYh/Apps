//
//  TodayFullScreenController.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayFullScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dismissHandler: (()->())?
    var todayItem: TodayItem?
    let height = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let closeButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
          return button
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCloseButton()
        setupFloatingControls()
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never // extend cell backround color to the status bar
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    fileprivate func setupFloatingControls() {
        
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 64, height: 64))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        print(scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = TodayFullscreenHeaderCell()
            //headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        let cell = TodayFullscreenDescriptionCell()
        return cell
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellHeight
        }
        return UITableView.automaticDimension//super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
}

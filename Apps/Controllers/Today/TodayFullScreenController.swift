//
//  TodayFullScreenController.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayFullScreenController: UITableViewController {
    
    @objc var dismissHandler: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = TodayFullscreenHeaderCell()
            cell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            return cell
        }
        let cell = TodayFullscreenDescriptionCell()
        return cell
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
}

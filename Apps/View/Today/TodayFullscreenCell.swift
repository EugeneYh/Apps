//
//  TodayFullscreenCell.swift
//  Apps
//
//  Created by Eugene on 31.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayFullscreenHeaderCell: UITableViewCell {
    
    let headerCell = TodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    fileprivate func setupView() {
        addSubview(headerCell)
        addSubview(closeButton)
        headerCell.fillSuperview()
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 80, height: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

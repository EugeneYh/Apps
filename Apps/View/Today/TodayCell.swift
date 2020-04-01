//
//  TodayCell.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        setupView()
    }
    
    fileprivate func setupView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

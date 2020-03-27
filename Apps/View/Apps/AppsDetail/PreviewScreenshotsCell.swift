//
//  PreviewScreenshotsCell.swift
//  Apps
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class PreviewScreenshotsCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.fillSuperview()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

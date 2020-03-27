//
//  AppPreviewCell.swift
//  Apps
//
//  Created by Eugene on 26.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    let horizontalController = AppReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        addSubview(titleLabel)
        addSubview(horizontalController.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

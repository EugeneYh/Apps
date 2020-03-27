//
//  AppScreenshotsCell.swift
//  Apps
//
//  Created by Eugene on 25.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 18))
    let horizontalController = PreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    fileprivate func setupView() {
        let verticalStackView = VerticalStackView(arangedViews: [titleLabel, horizontalController.view], spacing: 10)
        addSubview(verticalStackView)
        verticalStackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

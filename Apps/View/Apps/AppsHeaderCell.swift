//
//  AppsHeaderCell.swift
//  Apps
//
//  Created by Eugene on 14.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let appName = UILabel(text: "Facebook", font: .systemFont(ofSize: 14))
    let appDescription = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 28))
    let imageView = UIImageView(cornerRadius: 8)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        imageView.backgroundColor = .red
        appName.textColor = .blue
        appDescription.numberOfLines = 2
        
        let stackView = VerticalStackView(arangedViews: [appName, appDescription, imageView], spacing: 10)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

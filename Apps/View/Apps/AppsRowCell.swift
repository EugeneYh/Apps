//
//  AppsRowCell.swift
//  Apps
//
//  Created by Eugene on 12.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .boldSystemFont(ofSize: 13))
    let getButtom = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arangedViews: [nameLabel, companyLabel], spacing: 4), getButtom])
        stackView.alignment = .center
        stackView.spacing = 16
        
        getButtom.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButtom.constrainWidth(constant: 80)
        getButtom.constrainHeight(constant: 28)
        getButtom.layer.cornerRadius = 28/2
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MultipleAppsCell.swift
//  Apps
//
//  Created by Eugene on 07.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class MultipleAppsCell: UICollectionViewCell {
    
    var item: FeedResult? {
        didSet {
            nameLabel.text = item?.name
            companyLabel.text = item?.artistName
            imageView.sd_setImage(with: URL(string: item?.artworkUrl100 ?? ""))
        }
    }
    
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .boldSystemFont(ofSize: 13))
    let getButton = UIButton(type: .system)
    
    let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
        return divider
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arangedViews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.alignment = .center
        stackView.spacing = 16
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 28)
        getButton.layer.cornerRadius = 28/2
        getButton.setTitle("GET", for: .normal)
        
        addSubview(stackView)
        addSubview(dividerView)
        stackView.fillSuperview()
        dividerView.anchor(top: nil, leading: companyLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 1))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

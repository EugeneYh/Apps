//
//  TodayCell.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.categoryLabel
            titleLabel.text = todayItem.titleLabel
            imageView.image = todayItem.imageView
            descriptionLabel.text = todayItem.descriprionLabel
            backgroundColor = todayItem.backgroundColor
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 22))
    let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 28))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intellygently organize your life the right way", font: .systemFont(ofSize: 18), numberOfLines: 3)
    let imageContainerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        setupView()
    }
    
    fileprivate func setupView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        let verticalStackView = VerticalStackView(arangedViews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 10)
        addSubview(verticalStackView)
        
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        //verticalStackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        topConstraint = verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

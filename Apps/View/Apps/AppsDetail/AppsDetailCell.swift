//
//  AppsDetailCell.swift
//  Apps
//
//  Created by Eugene on 24.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class AppsDetailCell: UICollectionViewCell {
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    
    let appNameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    
    let priceButton = UIButton(title: "$4.99")
    
    
    let whatsNewLabel = UILabel(text: "What's new", font: .systemFont(ofSize: 20))
    
    let releaseNotesLabel = UILabel(text: "Release notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupView()
    }
    
    fileprivate func setupView() {
        appIconImageView.backgroundColor = .red
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = #colorLiteral(red: 0.2127566636, green: 0.4665074348, blue: 0.9760572314, alpha: 1)
        priceButton.constrainHeight(constant: 28)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 28/2
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        let topLabelsVerticalStackView = VerticalStackView(arangedViews: [appNameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()]), UIView()], spacing: 10)
        let horizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, topLabelsVerticalStackView])
        horizontalStackView.spacing = 10
        horizontalStackView.axis = .horizontal
        
        let mainVerticalStackView = VerticalStackView(arangedViews: [horizontalStackView, whatsNewLabel, releaseNotesLabel], spacing: 10)
        
        addSubview(mainVerticalStackView)
        mainVerticalStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

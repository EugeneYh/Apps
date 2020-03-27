//
//  ReviewCell.swift
//  Apps
//
//  Created by Eugene on 27.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    let authorLabel = UILabel(text: "Name SecondName", font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Body label", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9452908635, green: 0.941102922, blue: 0.9740957618, alpha: 1)
        layer.cornerRadius = 12
        clipsToBounds = true
        
        setupView()
    }
    
    fileprivate func setupView() {
        let topLabelsStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        topLabelsStackView.spacing = 10
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        authorLabel.textAlignment = .right
        
        let verticalStackView = VerticalStackView(arangedViews: [
            topLabelsStackView, starsLabel, bodyLabel], spacing: 10)
        
        addSubview(verticalStackView)
        verticalStackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

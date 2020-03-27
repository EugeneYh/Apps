//
//  ReviewCell.swift
//  Apps
//
//  Created by Eugene on 27.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Name SecondName", font: .systemFont(ofSize: 18))
    let stackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        return sv
    }()
    
    let bodyLabel = UILabel(text: "Body label", font: .systemFont(ofSize: 16), numberOfLines: 5)
    
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
            topLabelsStackView, stackView, bodyLabel], spacing: 10)
        
        addSubview(verticalStackView)
        verticalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

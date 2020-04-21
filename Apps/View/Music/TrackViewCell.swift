//
//  trackViewCell.swift
//  Apps
//
//  Created by Eugene on 20.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TrackViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let titleLabel = UILabel(text: "Track Title", font: .boldSystemFont(ofSize: 16), numberOfLines: 1)
    let trackInfoLabel = UILabel(text: "Album", font: .systemFont(ofSize: 14), numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        titleLabel.textAlignment = .left
        trackInfoLabel.textAlignment = .left
        
        let vStackView = UIStackView(arrangedSubviews: [titleLabel, trackInfoLabel])
        vStackView.axis = .vertical
//        vStackView.alignment = .center
        vStackView.spacing = 6
        
        let hStackView = UIStackView(arrangedSubviews: [imageView, vStackView])
        hStackView.spacing = 6
        hStackView.alignment = .center
        
        addSubview(hStackView)
        hStackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TrackViewCellFooter.swift
//  Apps
//
//  Created by Eugene on 21.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TrackViewCellFooter: UICollectionReusableView {
    
    let label = UILabel(text: "Loading more...", font: .boldSystemFont(ofSize: 18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        label.textAlignment = .center
        
        addSubview(activityIndicator)
        addSubview(label)
        activityIndicator.centerInSuperview()
        label.anchor(top: activityIndicator.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

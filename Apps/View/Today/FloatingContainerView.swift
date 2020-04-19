//
//  FloatingContainerView.swift
//  Apps
//
//  Created by Eugene on 18.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class FloatingContainerView: UIView {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    // setup view elements:
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "garden"))
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.constrainWidth(constant: 68)
        iv.constrainHeight(constant: 68)
        return iv
    }()
    
    let titleLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18), numberOfLines: 1)
    let descriptionLabel = UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 16), numberOfLines: 1)
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.constrainHeight(constant: 20)
        button.backgroundColor = .darkGray
        button.setTitle("GET", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        setupView()
    }
    
    fileprivate func setupView() {
        let vStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        vStackView.axis = .vertical
        vStackView.spacing = 10
        let hStackView = UIStackView(arrangedSubviews: [imageView, vStackView, getButton])
        hStackView.alignment = .center
        hStackView.spacing = 10
        getButton.constrainWidth(constant: 60)
        getButton.setTitleColor(.white, for: .normal)
        addSubview(blurEffect)
        addSubview(hStackView)
        blurEffect.fillSuperview()
        hStackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

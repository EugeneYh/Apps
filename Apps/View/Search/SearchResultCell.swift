//
//  SearchResultCell.swift
//  Apps
//
//  Created by Eugene on 06.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var result: Result! {
        didSet{
            appNameLabel.text = result.trackName
            categoryLabel.text = result.primaryGenreName
            ratingLabel.text = "\(result.averageUserRating ?? 0)"
            
            appImageIco.sd_setImage(with: URL(string: result.artworkUrl100), completed: nil)
            
            screenShot1ImageView.sd_setImage(with: URL(string: result.screenshotUrls![0]), completed: nil)
            if result.screenshotUrls!.count > 1 {
                screenShot2ImageView.sd_setImage(with: URL(string: result.screenshotUrls![1]), completed: nil)
            }
            if result.screenshotUrls!.count > 2 {
                screenShot3ImageView.sd_setImage(with: URL(string: result.screenshotUrls![2]), completed: nil)
            }
        }
    }
    
    let appImageIco: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo and Video"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.2MM"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    lazy var screenShot1ImageView = self.createScreenshotImageVeiw()
    lazy var screenShot2ImageView = self.createScreenshotImageVeiw()
    lazy var screenShot3ImageView = self.createScreenshotImageVeiw()

    fileprivate func createScreenshotImageVeiw() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appImageIco, VerticalStackView.init(arangedViews: [appNameLabel, categoryLabel, ratingLabel]), getButton
        ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView])
        screenshotsStackView.distribution = .fillEqually
        screenshotsStackView.spacing = 12
 
        let overalStackView = VerticalStackView(arangedViews: [infoTopStackView, screenshotsStackView], spacing: 16)
        
        addSubview(overalStackView)
        overalStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

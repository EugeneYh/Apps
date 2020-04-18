//
//  TodayMultipleAppCell.swift
//  Apps
//
//  Created by Eugene on 03.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet{
            categoryLabel.text = todayItem.categoryLabel
            titleLabel.text = todayItem.titleLabel
            multipleAppsController.apps = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    
    let categoryLabel = UILabel(text: "The Daily List", font: .systemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Test-Drive These CarPlay Apps", font: .boldSystemFont(ofSize: 26), numberOfLines: 2)
    
    let multipleAppsController = MultipleAppsController(mode: MultipleAppsController.Mode.small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        setupView()
    }
    
    fileprivate func setupView() {
        let stackView = VerticalStackView(arangedViews: [categoryLabel, titleLabel, multipleAppsController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

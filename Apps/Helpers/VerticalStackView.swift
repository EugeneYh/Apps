//
//  VerticalStackView.swift
//  Apps
//
//  Created by Eugene on 06.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arangedViews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arangedViews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



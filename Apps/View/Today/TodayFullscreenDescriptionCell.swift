//
//  TodayFullscreenDescriptionCell.swift
//  Apps
//
//  Created by Eugene on 30.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TodayFullscreenDescriptionCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()

        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the detail, from subtle visual effect to imaginative art styles. In these titles, you are sure to find something to marvel at, whether you are into funtasy worlds on neon-soaked dartboards", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dangeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dangeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dangeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dangeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

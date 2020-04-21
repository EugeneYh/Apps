//
//  BaseTabBarController.swift
//  Apps
//
//  Created by Eugene on 04.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(viewController: MusicController(), title: "Music", imageName: "music"),
            createNavigationController(viewController: TodayController(), title: "Today", imageName: "today_icon"),
            createNavigationController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavigationController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
        ]
    }
    
    fileprivate func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.navigationBar.prefersLargeTitles = true
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        return navigationController
        
    }
}

//
//  MainTabBarController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    required public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

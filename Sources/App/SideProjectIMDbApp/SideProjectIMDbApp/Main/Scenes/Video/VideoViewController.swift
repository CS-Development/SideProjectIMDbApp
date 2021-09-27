//
//  VideoViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import UIKit

final class VideoViewController: UIViewController {
    
    let headerTitles = ["Most Popular Movies",
                        "Most Popular Tvs"
                        ]
    
    let viewModel: VideoViewControllerViewModel
    let router: VideoViewRouting
    
    // MARK: - Init
    
    init(viewModel: VideoViewControllerViewModel, router: VideoViewRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

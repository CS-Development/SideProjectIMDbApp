//
//  VideoDetailsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 04.10.21.
//

import Foundation
import UIKit

final class VideoDetailsViewController: UIViewController {
    
    private var viewModel: VideoDetailsViewModel
    private var router: VideoViewRouter
    
    init(viewModel: VideoDetailsViewModel, router: VideoViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

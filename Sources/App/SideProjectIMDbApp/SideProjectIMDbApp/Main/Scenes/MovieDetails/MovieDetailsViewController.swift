//
//  MovieDetailsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    let viewModel: MovieDetailsViewControllerViewModel
    
    internal init(viewModel: MovieDetailsViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        title = viewModel.getTitle()
    }
}

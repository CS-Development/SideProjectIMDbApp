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
    
    // UI
    let scrollView = UIScrollView(frame: .zero)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "NOW PLAYING"
        label.numberOfLines = 0
        return label
    }()
    
    
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.width)
        titleLabel.frame = CGRect(x: 10, y: imageView.bottom+10, width: scrollView.width-20, height: 44)
    }
}

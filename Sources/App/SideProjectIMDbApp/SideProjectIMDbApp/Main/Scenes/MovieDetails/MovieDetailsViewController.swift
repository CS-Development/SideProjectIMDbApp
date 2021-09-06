//
//  MovieDetailsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    let viewModel: MovieDetailsViewControllerViewModel
    
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
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let crewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    internal init(viewModel: MovieDetailsViewControllerViewModel) {
        self.viewModel = viewModel
        print(viewModel.getDescription())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = viewModel.getTitle()
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(crewLabel)
        
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getTitle()
        crewLabel.text = viewModel.getCrew()
        guard let imageURL = viewModel.getImageUrl() else {
            imageView.image = UIImage(systemName: "film")
            return
        }
        _ = imageView.downloadImage(fromURL: imageURL)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.width)
        titleLabel.frame = CGRect(x: 10, y: imageView.bottom+10, width: scrollView.width-20, height: 44)
        titleLabel.sizeToFit()
        
        descriptionLabel.frame = CGRect(x: 10, y: titleLabel.bottom+10, width: scrollView.width-20, height: 200)
        descriptionLabel.sizeToFit()
        
        crewLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom+40, width: scrollView.width-20, height: 200)
        crewLabel.sizeToFit()
    }
    
    
}

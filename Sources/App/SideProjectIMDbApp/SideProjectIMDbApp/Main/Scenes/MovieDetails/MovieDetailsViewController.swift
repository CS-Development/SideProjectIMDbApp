//
//  MovieDetailsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 23.08.21.
//

import UIKit

protocol MovieDetailsDelegate: AnyObject {
    func reloadData()
}

class MovieDetailsViewController: UIViewController, MovieDetailsDelegate {
    
    let viewModel: MovieDetailsViewControllerViewModel
    
    let scrollView = UIScrollView(frame: .zero)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Khalil"
        label.numberOfLines = 0
        return label
    }()
    

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "-"
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "-"
        label.numberOfLines = 0
        return label
    }()
    
    private let crewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "-"
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
    
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(crewLabel)
        
        viewModel.loadMovie()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.title = self.viewModel.getTitle()
            self.titleLabel.text = self.viewModel.getTitle()
            self.descriptionLabel.text = self.viewModel.getTitle()
            self.crewLabel.text = "-"//viewModel.getCrew()
            guard let imageURL = self.viewModel.getImageUrl() else {
                self.imageView.image = UIImage(systemName: "film")
                return
            }
            
            do {
                if let cachedImage = try OnDiskImageCaching.publicCache.image(url: imageURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = cachedImage
                    }
                    return
                }
            } catch {
                print(error.localizedDescription)
            }

            _ = self.imageView.downloadImage(fromURL: imageURL)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.width)
        imageView.frame = CGRect(x: 0, y: label.bottom + 10, width: scrollView.width, height: scrollView.width)
        titleLabel.frame = CGRect(x: 10, y: imageView.bottom+10, width: scrollView.width-20, height: 44)
        //titleLabel.sizeToFit()
        
        descriptionLabel.frame = CGRect(x: 10, y: titleLabel.bottom+10, width: scrollView.width-20, height: 200)
        //descriptionLabel.sizeToFit()
        
        crewLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom+40, width: scrollView.width-20, height: 200)
        crewLabel.sizeToFit()
    }
    
    
}

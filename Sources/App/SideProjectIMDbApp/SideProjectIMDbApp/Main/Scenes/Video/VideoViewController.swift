//
//  VideoViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import UIKit

final class VideoViewController: UIViewController {
    
    let headerTitles = ["Popular trailers",
                        "Recent trailers"
                        ]
    
    let viewModel: VideoViewControllerViewModel
    let router: VideoViewRouting
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return VideoViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
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
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        configureCollectionView()
        viewModel.getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
//        setCollectionViewLayout(collectionView: collectionView)
    }
}

// MARK: Collection View configuration methods
extension VideoViewController {
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(VideoCollectionViewCell.self,
                                forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: Collection View Layout methods

extension VideoViewController {
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView
                    .elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        // Section 1
        
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension:.fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Group (made by items)
        
        // Vertical Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(280)),
            subitem: item,
            count: 1
        )
        
        // Section (made by groups)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
}

// MARK: Collection View Delegate & Data Source methods

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VideoCollectionViewCell.identifier,
                for: indexPath
        ) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let movie = viewModel.getMovieForIndexPath(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        let url = URL(string: movie.image)
        let convertedUrl = indexPath.section == 0 ? url?.convertToImdbImage192x264Url() : url?.convertToImdbImage384x528Url()
        
        let model = VideoCollectionViewCellViewModel(title: movie.title,
                                                     artworkURL: convertedUrl,
                                                     length: "1:01")
        cell.configure(with: model)
        cell.backgroundColor = .lightGray
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
                for: indexPath
        ) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let section = indexPath.section
        let title = headerTitles[section]
        header.configure(with: title)
        return header
    }
}

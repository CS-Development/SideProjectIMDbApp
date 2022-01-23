//
//  ViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 24.07.21.
//

import UIKit
import IMDbApiModule

class HomeViewController: UIViewController {

    let headerTitles = ["Most Popular Movies",
                        "Most Popular Tvs"
                        ]
    
    let viewModel: HomeViewControllerViewModel
    let router: HomeViewRouting
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
        
    // MARK: - Init
    
    init(viewModel: HomeViewControllerViewModel, router: HomeViewRouting) {
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
extension HomeViewController {
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionViewLayout(collectionView: UICollectionView) {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(collectionView.bounds.width-30)/2, height: 250)
                layout.itemSize = size
            }
    }
}

// MARK: Collection View Delegate & Data Source methods

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let homeSectionType = HomeSectionTypes(rawValue: section) else {
//            return 0
//        }
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
                for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let movie = viewModel.getMovieForIndexPath(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        let url = URL(string: movie.image)
        let convertedUrl = indexPath.section == 0 ? url?.convertToImdbImage192x264Url() : url?.convertToImdbImage384x528Url()
        let model = MovieCollectionViewCellViewModel(
            title: movie.title,
            artworkURL: convertedUrl
        )
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let movie = viewModel.getMovieForIndexPath(indexPath: indexPath) else { return }
        router.routeToMovieDetails(for: movie)
    }
    
}

extension HomeViewController {
    
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
        
        switch section {
        case 0:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension:.fractionalWidth(0.3),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let rowGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ),
                subitem: item,
                count: 3
            )
            
            // Vertical Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: rowGroup,
                count: 3
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                subitem: verticalGroup,
                count: 1
            )
            
            // Section (made by groups)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        //case 1:
        //    break
        default:
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
                    heightDimension: .absolute(390)),
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
    
    override func loadView() {
           super.loadView()

        let baseView = UIView()
        baseView.backgroundColor = UIColor(red: 13/255, green: 44/255, blue: 75/255, alpha: 1)
        self.view = baseView

        let progressIcon = UIActivityIndicatorView()
        progressIcon.translatesAutoresizingMaskIntoConstraints = false
        progressIcon.style = UIActivityIndicatorView.Style.large
           view.addSubview(progressIcon)
           progressIcon.startAnimating()

           var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(
                            item: progressIcon,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0))
           view.addConstraints(constraints)

       }

}

//
//  ViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 24.07.21.
//

import UIKit
import IMDbApiModule

class HomeViewController: UIViewController {
    
    private var manager: IMDbManagerProtocol
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private var mostPopularMovies = [MostPopularDataDetail]()
    // MARK: - Init
    
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        
        manager.getMostPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.mostPopularMovies = response.items
                    self?.collectionView.reloadData()
                    break
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        setCollectionViewLayout(collectionView: collectionView)
        }
    }
        
    func setCollectionViewLayout(collectionView: UICollectionView){
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(collectionView.bounds.width-30)/2, height: 250)
                layout.itemSize = size
        }
    }



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostPopularMovies.count > 20 ? 20 : mostPopularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
                for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = mostPopularMovies[indexPath.row]
        let model = MovieCollectionViewCellViewModel(
            title: movie.title,
            artworkURL: URL(string: movie.image)
        )
        cell.configure(with: model)
        cell.backgroundColor = .lightGray
        return cell
    }
    
}

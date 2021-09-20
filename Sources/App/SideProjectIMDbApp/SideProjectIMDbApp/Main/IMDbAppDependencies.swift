//
//  IMDbAppDependencies.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import Foundation
import UIKit
import NetworkingService
import IMDbApiModule


class FakeHomeViewRouter: HomeViewRouting {
    func routeToMovieDetails(for movie: MostPopularDataDetail) {
        //let vc = ProfileViewController(manager: <#T##IMDbManagerProtocol#>)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .brown
        vc.title = "Fake Test"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    var navigationController: UINavigationController?
}


class IMDbAppDependencies {
    var window: UIWindow?
    private init(){
        
    }
    
    static let shared = IMDbAppDependencies()
    
    private let inMemoryImageCache = InMemoryImageCaching.publicCache
    private let onDiskImageCache = OnDiskImageCaching.publicCache
    
    private lazy var client: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession.shared)
    }()
    
    private lazy var service: IMDbApiServiceProtocol = {
        let apiKey = "k_a1ew4rr2"//"k_4olf5ls3"
        return IMDbApiService(baseURL: URL(string: "https://imdb-api.com")!, client: client, apiKey: apiKey)
    }()
    
    private lazy var imdbManager: IMDbManagerProtocol = {
        return IMDbManager(service: service)
    }()
    
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    internal func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
    
    public func start() {
        
        let isLoggedIn:Bool = true
        
        if isLoggedIn {
            setRootViewController(makeMainTabBarController(manager: self.imdbManager))
        } else {
            setRootViewController(LoginViewController())
        }

    }
    
    // MARK: - Tab Bar Controller
    
    private func makeMainTabBarController(manager: IMDbManagerProtocol) -> UIViewController {
        
        let homeVC = makeHomeViewController()
        let searchVC = makeSearchViewController(manager: manager)
        let profileVC = makeProfileViewController(manager: manager)
        
        let tabController = MainTabBarController(
            viewControllers: [homeVC, searchVC, profileVC])
        return tabController
    }
    
    // MARK: - Home Controller
    
//    private func makeHomeViewController(manager: IMDbManagerProtocol) -> UIViewController {
//        let viewController = HomeViewController(manager: manager)
//        viewController.title = "Home"
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.title = "Home"
//        navigationController.tabBarItem.image = UIImage(systemName: "house")
//        return navigationController
//    }
    
    func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewControllerViewModel(manager: imdbManager)
        let router = HomeViewRouter()
        
        //let fakeRouter = FakeHomeViewRouter()
        
        let viewController = HomeViewController(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        router.navigationController = navigationController
        
        //fakeRouter.navigationController = navigationController
        return navigationController
    }
    
    // MARK: - Search Controller
    
    private func makeSearchViewController(manager: IMDbManagerProtocol) -> UIViewController {
        let viewModel = SearchViewModel(manager: manager)
        let viewController = SearchViewController(viewModel: viewModel)
        viewController.title = "Search"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return navigationController
    }
    
    // MARK: - Profile Controller
    
    private func makeProfileViewController(manager: IMDbManagerProtocol) -> UIViewController {
        let viewController = ProfileViewController(manager: manager)
        viewController.title = "Profile"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "contacts")
        return navigationController
        //return ProfileViewController(manager: manager)
    }
    
    //
    
    func makeMovieDetailsViewController(for movie: MostPopularDataDetail) -> UIViewController {
        let viewModel = MovieDetailsViewControllerViewModel(id: movie.id,
                                                            manager: imdbManager)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}



// Routing




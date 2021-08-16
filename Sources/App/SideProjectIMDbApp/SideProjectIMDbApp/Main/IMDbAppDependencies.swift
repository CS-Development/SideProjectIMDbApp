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

class IMDbAppDependencies {
    var window: UIWindow?
    
    private init(){
        
    }
    
    static let shared = IMDbAppDependencies()
    
    private lazy var client: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession.shared)
    }()
    
    private lazy var service: IMDbApiServiceProtocol = {
        let apiKey = "k_4olf5ls3"
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
    
    private func makeHomeViewController(manager: IMDbManagerProtocol) -> UIViewController {
        return HomeViewController(manager: manager)
    }
    
    private func makeMainTabBarController(manager: IMDbManagerProtocol) -> UIViewController {
        
        let homeVC = makeHomeViewController(manager: manager)
        let searchVC = makeSearchViewController(manager: manager)
        let profileVC = makeProfileViewController(manager: manager)
        
        let tabController = MainTabBarController(
            viewControllers: [homeVC, searchVC, profileVC])
        return tabController
    }
    
    private func makeSearchViewController(manager: IMDbManagerProtocol) -> UIViewController {
        return SearchViewController(manager: manager)
    }
    
    private func makeProfileViewController(manager: IMDbManagerProtocol) -> UIViewController {
        return ProfileViewController(manager: manager)
    }
}
 
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
    }
}

class SearchViewController: UIViewController {
    
    private let manager: IMDbManagerProtocol
    
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}

class ProfileViewController: UIViewController {
    
    private let manager: IMDbManagerProtocol
    
    init(manager: IMDbManagerProtocol) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
    }
}

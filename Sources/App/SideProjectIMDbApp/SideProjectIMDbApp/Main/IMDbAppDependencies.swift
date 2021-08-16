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
        let apiKey = "k_4olf5ls3"
        let client = URLSessionHTTPClient(session: URLSession.shared)
        let service: IMDbApiServiceProtocol  = IMDbApiService(baseURL: URL(string: "https://imdb-api.com")!, client: client, apiKey: apiKey)
        let manager: IMDbManagerProtocol = IMDbManager(service: service)
        
        setRootViewController(HomeViewController(manager: manager))
    }
}

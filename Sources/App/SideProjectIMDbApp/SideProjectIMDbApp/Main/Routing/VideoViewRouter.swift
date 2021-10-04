//
//  VideoViewRouter.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import UIKit
import IMDbApiModule

class VideoViewRouter: VideoViewRouting {
    
    var navigationController: UINavigationController?

    // route to video details screen
    func routeToVideoDetails(for movie: MostPopularDataDetail) {
        IMDbAppDependencies.shared.makeVideoDetailsViewController(for: movie) { [weak self] vc in
            guard let vc = vc else {
                //TODO: inform the user of failed fetch
                return
            }
            DispatchQueue.main.async {
                self?.navigationController?.show(vc, sender: self)
            }
        }
    }
}

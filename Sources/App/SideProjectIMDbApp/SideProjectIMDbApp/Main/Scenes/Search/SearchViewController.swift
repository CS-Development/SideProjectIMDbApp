//
//  SearchViewController+.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import UIKit
import IMDbApiModule

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
        
        manager.searchMovie(title: "Inception 2010") { answer in
            print(answer)
        }
    }
}

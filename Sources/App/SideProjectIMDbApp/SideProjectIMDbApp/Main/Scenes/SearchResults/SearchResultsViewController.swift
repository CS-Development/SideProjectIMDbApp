//
//  SearchResultsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 30.08.21.
//

import UIKit
import IMDbApiModule

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: String)
}

class SearchResultsViewController: UIViewController {
    weak var delegate: SearchResultsViewControllerDelegate?
    
    public func update(with: SearchData) {
        
    }
}

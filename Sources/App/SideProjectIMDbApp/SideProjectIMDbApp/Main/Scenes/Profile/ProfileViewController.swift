//
//  ProfileViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import UIKit
import IMDbApiModule

class ProfileViewController: UIViewController {
    
    private let manager: IMDbManagerProtocol
    
    private let tableView: UITableView = {
        let  tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // set frames
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        //TODO: this should instead fetch the user profile information
        manager.getBoxOffice { [weak self] result in
            switch result {
            case .success(let model):
            DispatchQueue.main.async {
                self?.updateUI(with: model)
            }
            case .failure(let error):
                print(error.localizedDescription)
                // TODO: failed to get the profile. alert the user
            }
        }
    }
    
    private func updateUI(with model: BoxOfficeWeekendData) { //TODO: replace with UserProfile
        tableView.isHidden = false
        
        // configure table models
        let user = UserProfile(firstName: "Joe",
                               secondName: "Smith",
                               email: "joe.smith@gmail.com",
                               userId: "@joe_smith",
                               subscription: "montly sub.", pictureUrl: model.items.first!.image)
        
        
        models.append("Full Name: \(user.displayName)")
        models.append("Email Address: \(user.email)")
        models.append("User ID: \(user.userId)")
        models.append("Subscription Plan: \(user.subscription)")
        createTableHeader(with: user.pictureUrl)
        
        tableView.reloadData()
    }
    
    private func createTableHeader(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        _ = imageView.downloadImage(fromURL: url)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        tableView.tableHeaderView = headerView
    }
}

extension  ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
}

struct UserProfile {
    let firstName: String
    let secondName: String
    let email: String
    let userId: String
    let subscription: String
    let pictureUrl: String
    
    var displayName: String {
        return firstName + " " + secondName
    }
}

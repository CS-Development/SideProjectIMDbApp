//
//  SearchResultDefaultTableViewCell.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 30.08.21.
//

import UIKit

class SearchResultDefaultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultDefaultTableViewCell"
    var task: URLSessionDataTask?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let actorLbl: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
   
        return label
    }()
    
    
    private let iconImageView: UIImageView = {
        let  imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(actorLbl)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        setImageAutolayout()

        setLabelAutolayout()
        
        setActorLblAutolayout()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    private func setImageAutolayout(){
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50), iconImageView.widthAnchor.constraint(equalToConstant: 20), iconImageView.heightAnchor.constraint(equalToConstant: 80)])
    }
    
    private func setLabelAutolayout(){
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 5),
                                     label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 30)])
    }
    
    private func setActorLblAutolayout(){
        actorLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          actorLbl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
          actorLbl.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 30)
        ])
    }
   
}

extension SearchResultDefaultTableViewCell {
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        actorLbl.text = viewModel.resultType
        guard let url = viewModel.artworkURL else { return }
        
        do {
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: url) {
                DispatchQueue.main.async {
                    self.iconImageView.image = cachedImage
                }
                return
            }
        } catch {
        }
        
        task = iconImageView.downloadImage(fromURL: url)
    }
}

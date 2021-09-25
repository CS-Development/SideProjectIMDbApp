//
//  SearchResultDefaultTableViewCell.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 30.08.21.
//

import UIKit

class SearchResultDefaultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
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
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // set image view frame
       // iconImageView.frame = CGRect(x: 4, y: contentView.center.y, width: 20, height: 80)
        setImageAutolayout()
        // set label frame
      //  label.frame = CGRect(x: iconImageView.right + 4, y: 20, width: self.bounds.width - 20, height: 20)
        setLabelAutolayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
//        iconImageView.image = //load an image from the view model
        self.iconImageView.image = UIImage(systemName: "film")
    }
    
    private func setImageAutolayout(){
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50), iconImageView.widthAnchor.constraint(equalToConstant: 20), iconImageView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
    private func setLabelAutolayout(){
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), label.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 50), label.widthAnchor.constraint(equalToConstant: 20), label.heightAnchor.constraint(equalToConstant: 90)])
    }
}

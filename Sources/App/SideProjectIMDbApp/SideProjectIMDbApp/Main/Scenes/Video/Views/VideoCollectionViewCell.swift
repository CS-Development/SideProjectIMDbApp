//
//  VideoCollectionViewCell.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"
    var task: URLSessionDataTask?
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.circle")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let lenghtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(playIcon)
        contentView.addSubview(lenghtLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height-44)
        label.frame = CGRect(x: 10, y: height-44, width: width-20, height: 44)
        label.sizeToFit()
        
        playIcon.frame = CGRect(x: 0, y: height-44, width: 44, height: 44)
        label.frame = CGRect(x: 10+playIcon.right, y: height-44, width: width-10-playIcon.right, height: 44)
        label.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        task?.cancel()
        task = nil
        imageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: VideoCollectionViewCellViewModel) {
        label.text = viewModel.title
        lenghtLabel.text = viewModel.length
        guard let url = viewModel.artworkURL else { return }
        
        do {
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: url) {
                DispatchQueue.main.async {
                    self.imageView.image = cachedImage
                }
                return
            }
        } catch {
        }
        
        task = imageView.downloadImage(fromURL: url)
    }
}

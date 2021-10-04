//
//  VideoDetailsViewController.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 04.10.21.
//

import Foundation
import UIKit
import AVFoundation
import SafariServices

final class VideoDetailsViewController: UIViewController {
    
    private var viewModel: VideoDetailsViewModel
    private var router: VideoViewRouter
    
    // UI
    lazy private var scrollView: UIScrollView = {
        UIScrollView(frame: .zero)
    }()
    
    
    /////////////
    // TRAILER VIEW
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    /////////////
    
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = viewModel.videoStatus
        label.numberOfLines = 0
        return label
    }()
    
    
    init(viewModel: VideoDetailsViewModel, router: VideoViewRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        imageView.layer.addSublayer(playerLayer)
        loadTrailerPreview()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playTrailer))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func playWebTrailer() {
        guard let url = viewModel.getTrailerUrl() else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func playTrailer() {
        print("playTrailer")
        //guard let url = viewModel.getTrailerUrl() else { return }
        guard let url = URL(string: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4") else {
            return
        }
        player = AVPlayer(url: url)
        playerLayer.player = player
        //playerLayer.player?.volume = 0
        playerLayer.player?.play()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.width * 9/16)
        titleLabel.frame = CGRect(x: 10, y: imageView.bottom+10, width: scrollView.width-20, height: 44)
        
        playerLayer.frame = imageView.frame
    }
    
    private func loadTrailerPreview() {
        guard let imageURL = self.viewModel.getImageUrl() else {
            self.imageView.image = UIImage(systemName: "film")
            return
        }
        
        do {
            if let cachedImage = try OnDiskImageCaching.publicCache.image(url: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = cachedImage
                }
                return
            }
        } catch {
            print(error.localizedDescription)
        }

        _ = self.imageView.downloadImage(fromURL: imageURL)
    }
}

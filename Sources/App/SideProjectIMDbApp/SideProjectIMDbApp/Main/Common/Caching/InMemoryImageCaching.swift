//
//  InMemoryImageCaching.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 13.09.21.
//

import UIKit

/// In memory caching is easy to implement and also quick, because it loads directly from RAM
class InMemoryImageCaching {
    
    static let publicCache = InMemoryImageCaching()
    
    private var cachedImages = NSCache<NSURL, UIImage>()
    
    private init() {
    }
    
    public final func image(url: URL) -> UIImage? {
        
        // lookup into the cache
        // if found, return the image
        return cachedImages.object(forKey: url as NSURL)
    }
    
    public final func cacheImage(_ image: UIImage, url: URL) {
        // Cache the image
        cachedImages.setObject(image, forKey: url as NSURL)
    }
}

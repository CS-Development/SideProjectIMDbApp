//
//  InMemoryImageCaching.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 13.09.21.
//

import UIKit

class InMemoryImageCaching {
    
    static let publicCache = InMemoryImageCaching()
    
    private var cachedImages = [URL: UIImage]()
    
    private init() { }
    
    public final func image(url: URL) -> UIImage? {
        
        //TODO: lookup into the cache
        //TODO: if found, return the image
        return cachedImages[url]
    }
    
    public final func cacheImage(_ image: UIImage, url: URL) {
        //TODO: Cache the image
        cachedImages[url] = image
    }
}

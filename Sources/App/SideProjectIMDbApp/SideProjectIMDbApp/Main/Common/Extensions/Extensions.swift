//
//  Extensions.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 16.08.21.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}

extension UIImage {
    
    //NOTE: This is not thread safe, please run it on a background thread.
    convenience init?(fromFile filePath:String) {
        guard let url = URL(string: filePath) else {
            return nil
        }
        
        self.init(fromURL: url)
    }
    
    //NOTE: This is not thread safe, please run it on a background thread.
    convenience init?(fromURL url:URL) {
        let imageData: Data
        
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            return nil
        }
        
        self.init(data: imageData)
    }
    
}

//
//  ImageCache.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/6/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import Foundation
import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    /// Private image cache.
    
    private var cache = [String: UIImage]()
    
    // Note, this is `private` to avoid subclassing this; singletons shouldn't be subclassed.
    
    private init() { }
    
    /// Subscript operator to retrieve and update cache
    
    subscript(key: String) -> UIImage? {
        get {
            return cache[key]
        }
        
        set (newValue) {
            cache[key] = newValue
        }
    }
}

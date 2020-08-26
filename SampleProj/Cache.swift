//
//  Cache.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 26/08/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    private let cache = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    
    private init(){}
    
    
    func get(for url: String) -> UIImage? {
        return self.cache.object(forKey: url as NSString)
    }
    
    func get(for url: URL) -> UIImage? {
        return self.get(for: url.absoluteString)
    }
    
    
    
    
    func set(for url : String, with image : UIImage) {
         self.cache.setObject(image, forKey: url as NSString)
    }
    
    func set(for url : URL, with image : UIImage) {
        self.set(for: url.absoluteString, with: image)
    }
}


extension UIImageView {
 
    func loadImage(for imageStr : String){
        self.loadImage(for: imageStr) { [weak self](image, error) in
            if let img = image {
                self?.image = img
            }
        }
    }
    
    
    func loadImage(for imageStr : String, with completionBlock : @escaping (UIImage?,Error?)->Void) {
        if let img = ImageCache.shared.get(for: imageStr) {
            completionBlock(img,nil)
        }else{
            imageStr.executeAPI { [weak self](imgData, error) in
                if self != nil {
                    if let data = imgData, let image = UIImage.init(data: data){
                        ImageCache.shared.set(for: imageStr, with: image)
                        completionBlock(image,error)
                    }else{
                        completionBlock(nil,error)
                    }
                }else{
                    completionBlock(nil,nil)
                }
            }
            
        }
    }
    
    
    
    func loadImage(for imageStr : URL){
        self.loadImage(for: imageStr.absoluteString) { [weak self](image, error) in
            if let img = image {
                self?.image = img
            }
        }
    }
    
    
    func loadImage(for imageStr : URL, with completionBlock : @escaping (UIImage?,Error?)->Void) {
        if let img = ImageCache.shared.get(for: imageStr) {
            completionBlock(img,nil)
        }else{
            imageStr.executeAPI { [weak self](imgData, error) in
                if self != nil {
                    if let data = imgData, let image = UIImage.init(data: data){
                        ImageCache.shared.set(for: imageStr, with: image)
                        completionBlock(image,error)
                    }else{
                        completionBlock(nil,error)
                    }
                }else{
                    completionBlock(nil,nil)
                }
            }
            
        }
    }
}

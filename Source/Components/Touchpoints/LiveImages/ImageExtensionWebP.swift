//
//  ImageExtensionWebP.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 01/12/2022.
//

import UIKit
import ImageIO
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

extension UIImage {
    
    public class func webPImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func webPImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        return webPImageWithData(imageData)
    }
    
    public class func webPImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "webp") else {
                print("webP: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("webP: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return webPImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        if #available(iOS 14.0, *) {
            let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
            
                let webPProperties: CFDictionary = unsafeBitCast(
                    CFDictionaryGetValue(cfProperties,
                                         Unmanaged.passUnretained(kCGImagePropertyWebPDictionary).toOpaque()),
                    to: CFDictionary.self)
            
            var delayObject: AnyObject = unsafeBitCast(
                CFDictionaryGetValue(webPProperties,
                    Unmanaged.passUnretained(kCGImagePropertyWebPUnclampedDelayTime).toOpaque()),
                to: AnyObject.self)
            if delayObject.doubleValue == 0 {
                delayObject = unsafeBitCast(CFDictionaryGetValue(webPProperties,
                    Unmanaged.passUnretained(kCGImagePropertyWebPDelayTime).toOpaque()), to: AnyObject.self)
            }
            
            delay = delayObject as! Double
        }
        
        if delay < 0.1 {
            delay = 0.05
        }
            
        
        return delay
    }

}


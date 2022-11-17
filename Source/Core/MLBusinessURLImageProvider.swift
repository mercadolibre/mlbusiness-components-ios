//
//  MLBusinessURLImageProvider.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 07/07/2020.
//

import Foundation
import ImageIO

class MLBusinessURLImageProvider: NSObject, MLBusinessImageProvider {
    func getImage(key: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: key) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            completion(image)
            #if DEBUG
            print("Retrieve image from Cache")
            #endif
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    #if DEBUG
                    print("Retrieve image from Network")
                    #endif
                    DispatchQueue.main.async { completion(image) }
                }
            }).resume()
        }
    }
    
    func getGIFImage(key: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: key) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage.gifImageWithData(data) {
            completion(image)
            #if DEBUG
            print("Retrieve image from Cache")
            #endif
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage.gifImageWithData(data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    #if DEBUG
                    print("Retrieve image from Network")
                    #endif
                    DispatchQueue.main.async { completion(image) }
                }
            }).resume()
        }
    }
}

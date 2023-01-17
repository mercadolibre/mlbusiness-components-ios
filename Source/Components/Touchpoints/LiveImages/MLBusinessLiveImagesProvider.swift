//
//  MLBusinessLiveImagesProvider.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 16/01/2023.
//

import Foundation

class MLBusinessLiveImagesProvider {
    
    static let shared = MLBusinessLiveImagesProvider()
    private let cache = NSCache<NSString, NSData>()
    
    public init(){}
    
    public func getLiveImageData(from key: String, completion: @escaping (Data?) -> Void) {

        if let data = cache.object(forKey: NSString(string: key)) {
            completion(data as Data)
            return
        }
        
        guard let url = URL(string: key)else {
            completion(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            [weak self] data, response, error in
            
            guard let data = data, error == nil, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                self?.cache.setObject(NSData(data: data), forKey: NSString(string: key))
                completion(data)
            }
        })
        
        downloadTask.resume()
    }
    
    
}

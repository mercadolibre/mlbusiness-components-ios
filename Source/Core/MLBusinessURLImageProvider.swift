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
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage.webPImageWithData(data) {
            completion(image)
            #if DEBUG
            print("Retrieve image from Cache")
            #endif
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage.webPImageWithData(data) {
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
    
    func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
        {
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

            guard let destinationUrl = documentsUrl?.appendingPathComponent(url.lastPathComponent) else { return }

            if FileManager().fileExists(atPath: destinationUrl.path)
            {
                print("File already exists [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let task = session.dataTask(with: request, completionHandler:
                {
                    data, response, error in
                    if error == nil
                    {
                        if let response = response as? HTTPURLResponse
                        {
                            if response.statusCode == 200
                            {
                                if let data = data
                                {
                                    if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                    {
                                        completion(destinationUrl.path, error)
                                    }
                                    else
                                    {
                                        completion(destinationUrl.path, error)
                                    }
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                        }
                    }
                    else
                    {
                        completion(destinationUrl.path, error)
                    }
                })
                task.resume()
            }
        }
    
//    func getLocalUrl(key: String, completion: @escaping (String?) -> Void) {
//        guard let url = URL(string: key) else { return }
//        let cache = URLCache.shared
//        let request = URLRequest(url: url)
//
//        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//
//        guard let destinationURL = documentsUrl?.appendingPathComponent(url.lastPathComponent) else { return }
//
//
//        if FileManager().fileExists(atPath: destinationURL.path)
//        {
//            print("File already exists [\(destinationURL.path)]")
//            completion(destinationURL.path)
//        } else {
//            if let data = cache.cachedResponse(for: request)?.data, data.write(to: destinationURL, atomically: true)
//            {
//                print("file saved [\(destinationURL.path)]")
//                                completion(destinationURL.path)
//            } else {
//                print("error saving file")
//                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
//
//            }
//        }
//
//
//        if let urlResponse = cache.cachedResponse(for: request), let path = urlResponse.{
//            completion(url)
//            #if DEBUG
//            print("Retrieve image from Cache")
//            #endif
//        } else {
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
//                    let cachedData = CachedURLResponse(response: response, data: data)
//                    cache.storeCachedResponse(cachedData, for: request)
//                    #if DEBUG
//                    print("Retrieve image from Network")
//                    #endif
//                    DispatchQueue.main.async { completion(image) }
//                }
//            }).resume()
//        }
//    }
    
}

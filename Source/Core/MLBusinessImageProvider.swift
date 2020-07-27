//
//  MLBusinessImageProvider.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 07/07/2020.
//

import Foundation

public protocol MLBusinessImageProvider: class {
    func getImage(key: String, completion: @escaping (UIImage?) -> Void)
}

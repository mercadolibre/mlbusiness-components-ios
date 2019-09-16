//
//  MLBusinessResourceManager.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//

import Foundation

internal final class MLBusinessResourceManager {
    static let shared = MLBusinessResourceManager()

    func getBundle() -> Bundle? {
        return Bundle(for: MLBusinessResourceManager.self)
    }

    func getImage(_ name: String?) -> UIImage? {
        guard let name = name, let bundle = MLBusinessResourceManager.shared.getBundle() else {
            return nil
        }
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

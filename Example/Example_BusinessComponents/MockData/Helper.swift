//
//  Helper.swift
//  Example_BusinessComponents
//
//  Created by Gaston Maspero on 06/11/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let strongDictionary = dictionary else {
                return [:]
        }
        
        return strongDictionary
    }
}

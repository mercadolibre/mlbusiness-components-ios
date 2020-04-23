//
//  MLBusinessTouchpointsResponse.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

public struct MLBusinessTouchpointsResponse {
    let type: String
    let content: [String : Any]
    
    public init(type: String, content: [String : Any]) {
        self.type = type
        self.content = content
    }
}

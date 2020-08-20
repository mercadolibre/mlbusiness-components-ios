//
//  MLBusinessMultipleDescriptionModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 19/08/2020.
//

import Foundation

@objc public class MLBusinessMultipleDescriptionModel: NSObject, Codable, MLBusinessRowMainDescriptionData {
    private let type: String
    private let content: String
    private let color: String?
    
    public init(type: String, content: String, color: String?) {
        self.type = type
        self.content = content
        self.color = color
    }
    
    public init(data: MLBusinessRowMainDescriptionData) {
        self.type = data.getType()
        self.content = data.getContent()
        self.color = data.getColor()
    }
    
    public func getType() -> String {
        return type
    }
    
    public func getContent() -> String {
        return content
    }
    
    public func getColor() -> String? {
        return color
    }
}

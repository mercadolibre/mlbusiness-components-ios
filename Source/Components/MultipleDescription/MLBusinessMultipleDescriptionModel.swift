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
    private let background: String?
    private let compressible: Bool?

    public init(type: String,
                content: String,
                color: String?,
                background: String? = "#FFFFFF",
                compressible: Bool? = false) {
        self.type = type
        self.content = content
        self.color = color
        self.background = background
        self.compressible = compressible
    }
    
    public init(data: MLBusinessRowMainDescriptionData) {
        self.type = data.getType()
        self.content = data.getContent()
        self.color = data.getColor()
        self.background = "#FFFFFF"
        self.compressible = false
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

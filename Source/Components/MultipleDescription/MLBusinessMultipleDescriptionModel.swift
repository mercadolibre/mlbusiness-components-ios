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
    private let compressible: Bool?
    private let style: MlBusinessMultipleDescriptionStyleModel?

    public init(type: String,
                content: String,
                color: String?,
                compressible: Bool? = false,
                style: MlBusinessMultipleDescriptionStyleModel? = MlBusinessMultipleDescriptionStyleModel(fontWeight: nil)) {
        self.type = type
        self.content = content
        self.color = color
        self.compressible = compressible
        self.style = style
    }
    
    public init(data: MLBusinessRowMainDescriptionData) {
        self.type = data.getType()
        self.content = data.getContent()
        self.color = data.getColor()
        self.compressible = false
        self.style = nil
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
    
    public func getStyle() -> MlBusinessMultipleDescriptionStyleModel? {
        return style
    }
}

public class MlBusinessMultipleDescriptionStyleModel: NSObject, Codable {
    
    private let fontWeight: String?

    public init(fontWeight: String?) {
        self.fontWeight = fontWeight
    }

    public func getFontWeight() -> String? {
        fontWeight
    }
}

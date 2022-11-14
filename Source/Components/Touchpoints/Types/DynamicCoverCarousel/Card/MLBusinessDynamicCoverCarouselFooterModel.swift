//
//  MLBusinessDynamicCoverCarouselFooterModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCoverCarouselFooterModel: Codable {
    let backgroundColor: String?
    let text: String?
    let textColor: String?
    
    public init(backgroundColor: String?,
                text: String?,
                textColor: String?) {
        
        self.backgroundColor = backgroundColor
        self.text = text
        self.textColor = textColor
    }
}

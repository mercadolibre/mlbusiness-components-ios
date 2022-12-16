//
//  MLBusinessLiveImagesModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 15/12/2022.
//

import Foundation

public struct MLBusinessLiveImagesModel: Codable {
    
    private let thumbnail: String?
    private let mediaLink: String?
    
    public init(thumbnail: String?, mediaLink: String?){
        self.thumbnail = thumbnail
        self.mediaLink = mediaLink
    }
    
    public func getThumbnail() -> String? {
        return thumbnail
    }
    
    public func getMediaLink() -> String? {
        return mediaLink
    }
}

public enum MLBusinessLiveImagesType: String, Codable {
    case webp
    case gif
}

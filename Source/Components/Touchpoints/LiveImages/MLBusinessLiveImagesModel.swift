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
    private let mobileData: Bool?
    private let batteryIgnore: Bool?
    
    public init(thumbnail: String?, mediaLink: String?, mobileData: Bool? = false, batteryIgnore: Bool? = false){
        self.thumbnail = thumbnail
        self.mediaLink = mediaLink
        self.mobileData = mobileData
        self.batteryIgnore = batteryIgnore
    }
    
    public func getThumbnail() -> String? {
        return thumbnail
    }
    
    public func getMediaLink() -> String? {
        return mediaLink
    }
    
    public func shouldIgnoreMobileData() -> Bool? {
        return mobileData
    }
    
    public func shouldIgnoreBattery() -> Bool? {
        return batteryIgnore
    }
}

public enum MLBusinessLiveImagesType: String, Codable {
    case webp
    case gif
}

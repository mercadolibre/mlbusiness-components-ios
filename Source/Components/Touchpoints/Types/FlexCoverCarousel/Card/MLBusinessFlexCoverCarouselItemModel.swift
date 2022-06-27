//
//  MLBusinessDiscountCarouselItemModel.swift
//  FXBlurView
//
//  Created by Lautaro Bonasora on 19/04/2022.
//

import Foundation


public struct MLBusinessFlexCoverCarouselItemModel: Codable {
    public let link: String?
    public let backgroundColor: String?
    public let logos: [FlexCoverCarouselLogo]?
    public let pill: FlexCoverCarouselPill?
    public let imageHeader: String?
    public let title: FlexCoverCarouselItemText?
    public let subtitle: FlexCoverCarouselItemText?
    public let mainDescription: FlexCoverCarouselItemText?
    public let tracking: MLBusinessItemModelTracking?
  
    public init (title: FlexCoverCarouselItemText?, subtitle: FlexCoverCarouselItemText?, mainDescription: FlexCoverCarouselItemText? ,pill: FlexCoverCarouselPill?, imageHeader: String?,  link: String?, textColor: String?, backgroundColor: String?, logos: [FlexCoverCarouselLogo], tracking: MLBusinessItemModelTracking?) {
        self.title = title
        self.subtitle = subtitle
        self.mainDescription = mainDescription
        self.pill = pill
        self.imageHeader = imageHeader
        self.link = link
        self.backgroundColor = backgroundColor
        self.logos = logos
        self.tracking = tracking
    }
}

extension MLBusinessFlexCoverCarouselItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }
    
    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

public struct FlexCoverCarouselItemText: Codable {
    public let text: String
    public let textColor: String
}

public struct FlexCoverCarouselLogo: Codable {
    public let type: FlexCoverCarouselLogoType
    public let image: String?
    public let style: FlexCoverCarouselLogoStyle?
}

public enum FlexCoverCarouselLogoType: String, Codable {
    case image
    case text
}

public struct FlexCoverCarouselLogoStyle: Codable {
    public let width: Int?
    public let height: Int?
    public let border: Int?
    public let borderColor: String?
    public let backgroundColor: String?
}

public struct FlexCoverCarouselPill: Codable {
    public let text: String?
    public let textColor: String?
    public let backgroundColor: String?
    public let borderColor: String?
}

//
//  MLBusinessDiscountCarouselItemModel.swift
//  FXBlurView
//
//  Created by Lautaro Bonasora on 19/04/2022.
//

import Foundation


public class MLBusinessFlexCoverCarouselItemModel: NSObject, Codable {
    public let link: String?
    public let backgroundColor: String?
    public let logos: [FlexCoverCarouselLogo]?
    public let pill: FlexCoverCarouselPill?
    public let imageHeader: String?
    public let title: FlexCoverCarouselItemText?
    public let subtitle: FlexCoverCarouselItemText?
    public let mainDescription: FlexCoverCarouselItemText?
  
    public init (title: FlexCoverCarouselItemText?, subtitle: FlexCoverCarouselItemText?, mainDescription: FlexCoverCarouselItemText? ,pill: FlexCoverCarouselPill?, imageHeader: String?,  link: String?, textColor: String?, backgroundColor: String?, logos: [FlexCoverCarouselLogo]) {
        self.title = title
        self.subtitle = subtitle
        self.mainDescription = mainDescription
        self.pill = pill
        self.imageHeader = imageHeader
        self.link = link
        self.backgroundColor = backgroundColor
        self.logos = logos
    }
}

extension MLBusinessFlexCoverCarouselItemModel {
    public func getLink() -> String? {
        return link
    }
    
    public func getBackgroundColor() -> String? {
        return backgroundColor
    }
    
    public func getPill() -> FlexCoverCarouselPill? {
        return pill
    }
    
    public func getImageHeader() -> String? {
        return imageHeader
    }
    
    public func getTitle() -> FlexCoverCarouselItemText? {
        return title
    }
    
    public func getSubtitle() -> FlexCoverCarouselItemText? {
        return subtitle
    }
    
    public func getMainDescription() -> FlexCoverCarouselItemText? {
        return mainDescription
    }
}

public class FlexCoverCarouselItemText: NSObject, Codable {
    public let text: String
    public let textColor: String

    public init(text: String, textColor: String) {
        self.text = text
        self.textColor = textColor
    }
}

public class FlexCoverCarouselLogo: NSObject, Codable {
    public let type: String?
    public let image: String?
    public let style: FlexCoverCarouselLogoStyle?
    
    public init(type: String?, image: String?, style: FlexCoverCarouselLogoStyle?){
        self.type = type
        self.image = image
        self.style = style
    }
}

public class FlexCoverCarouselLogoStyle: NSObject, Codable {
    public let width: Int?
    public let height: Int?
    public let border: Int?
    public let borderColor: String?
    public let backgroundColor: String?
    
    public init(width: Int, height: Int, border: Int, borderColor: String?, backgroundColor: String?){
        self.width = width
        self.height = height
        self.border = border
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
    }
}

public class FlexCoverCarouselPill: NSObject, Codable {
    public let text: String?
    public let textColor: String?
    public let backgroundColor: String?
    public let borderColor: String?
    
    public init(text: String?, textColor: String?, backgroundColor: String?, borderColor: String?) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
    }
}

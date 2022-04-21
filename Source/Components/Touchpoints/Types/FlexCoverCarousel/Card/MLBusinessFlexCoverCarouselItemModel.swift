//
//  MLBusinessDiscountCarouselItemModel.swift
//  FXBlurView
//
//  Created by Lautaro Bonasora on 19/04/2022.
//

import Foundation


public class MLBusinessFlexCoverCarouselItemModel: NSObject, Codable {
    
    let link: String?
    let backgroundColor: String?
    let logos: [FlexCoverCarouselLogo]
    let pill: FlexCoverCarouselPill?
    let imageHeader: String?
    let title: FlexCoverCarouselItemText?
    let subtitle: FlexCoverCarouselItemText?
    let mainDescription: FlexCoverCarouselItemText?
 
    public func getLink() -> String? {
        return link
    }
        
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


public class FlexCoverCarouselItemText: NSObject, Codable {
    let text: String
    let textColor: String

    public init(text: String, textColor: String) {
        self.text = text
        self.textColor = textColor
    }
}

public class FlexCoverCarouselLogo: NSObject, Codable {
    let type: String?
    let image: String?
    let style: FlexCoverCarouselLogoStyle?
    
}

public class FlexCoverCarouselLogoStyle: NSObject, Codable {
    let width: Int?
    let height: Int?
    let border: Int?
    let borderColor: String?
    let backgroundColor: String?
    
    public init(width: Int, height: Int, border: Int, borderColor: String?, backgroundColor: String?){
        self.width = width
        self.height = height
        self.border = border
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
    }
}

public class FlexCoverCarouselPill: NSObject, Codable {
    let text: String?
    let textColor: String?
    let backgroundColor: String?
    let borderColor: String?
    
    public init(text: String?, textColor: String?, backgroundColor: String?, borderColor: String?) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
    }
}




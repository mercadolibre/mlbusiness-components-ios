//
//  MLBusinessTouchpointsMultipleRowModel.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation

class MLBusinessTouchpointsMultipleRowModel: NSObject, Codable {
    private let title: String?
    private let subtitle: String?
    private let items: [MLBusinessMultipleRowItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessMultipleRowItemModel]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.items = []
    }
}

extension MLBusinessTouchpointsMultipleRowModel: MLBusinessTouchpointsMultipleRowData {
    func getTitle() -> String? {
        return title
    }

    func getSubtitle() -> String? {
        return subtitle
    }

    func getItems() -> [MLBusinessMultipleRowItemModel] {
        return items
    }
}

extension MLBusinessTouchpointsMultipleRowModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}

public class MLBusinessMultipleRowItemModel: NSObject, Codable {
    private let leftImage: String?
    private let leftImageAccessory: String?
    private let mainTitle: String
    private let mainSubtitle: String?
    private let mainDescription: [MLBusinessRowMainDescription]?
    private let rightPrimaryLabel: String?
    private let rightSecondaryLabel: String?
    private let rightMiddleLabel: String?
    private let rightTopLabel: String?
    private let rightLabelStatus: String?
    private let rightBottomInfo: MLBusinessRowRightBottomInfo?
    private let link: String?
    private let tracking: MLBusinessItemModelTracking?
    
    public init(leftImage: String?, leftImageAccessory: String?, mainTitle: String, mainSubtitle: String?, mainDescription: [MLBusinessRowMainDescription]?, rightPrimaryLabel: String?, rightSecondaryLabel: String?, rightMiddleLabel: String?, rightTopLabel: String?, rightLabelStatus: String?, rightBottomInfo: MLBusinessRowRightBottomInfo?, link: String?, tracking: MLBusinessItemModelTracking?) {
        self.leftImage = leftImage
        self.leftImageAccessory = leftImageAccessory
        self.mainTitle = mainTitle
        self.mainSubtitle = mainSubtitle
        self.mainDescription = mainDescription
        self.rightPrimaryLabel = rightPrimaryLabel
        self.rightSecondaryLabel = rightSecondaryLabel
        self.rightMiddleLabel = rightMiddleLabel
        self.rightTopLabel = rightTopLabel
        self.rightLabelStatus = rightLabelStatus
        self.rightBottomInfo = rightBottomInfo
        self.link = link
        self.tracking = tracking
    }
}

extension MLBusinessMultipleRowItemModel: MLBusinessRowData {
    public func getLeftImage() -> String? {
        return leftImage
    }
    
    public func getLeftImageAccessory() -> String? {
        return leftImageAccessory
    }
    
    public func getMainTitle() -> String {
        return mainTitle
    }
    
    public func getMainSubtitle() -> String? {
        return mainSubtitle
    }
    
    public func getMainDescription() -> [MLBusinessRowMainDescriptionData]? {
        return mainDescription
    }
    
    public func getRightPrimaryLabel() -> String? {
        return rightPrimaryLabel
    }
    
    public func getRightSecondaryLabel() -> String? {
        return rightSecondaryLabel
    }
    
    public func getRightMiddleLabel() -> String? {
        return rightMiddleLabel
    }
    
    public func getRightTopLabel() -> String? {
        return rightTopLabel
    }
    
    public func getRightLabelStatus() -> String? {
        return rightLabelStatus
    }
    
    public func getRightBottomInfo() -> MLBusinessRowRightBottomInfoData? {
        return rightBottomInfo
    }
    
    public func getLink() -> String? {
        return link
    }
        
    public func getTrackingId() -> String? {
        return trackingId
    }

    public func getEventData() -> [String : Any]? {
        return eventData?.rawValue
    }
}

public class MLBusinessRowMainDescription: NSObject, Codable {
    private let type: String
    private let content: String
    private let color: String?
    
    public init(type: String, content: String, color: String?) {
        self.type = type
        self.content = content
        self.color = color
    }
}

extension MLBusinessRowMainDescription: MLBusinessRowMainDescriptionData {
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

public class MLBusinessRowRightBottomInfo: NSObject, Codable {
    private let icon: String?
    private let label: String?
    private let format: MLBusinessRowRightBottomInfoFormat?
    
    public init(icon: String?, label: String?, format: MLBusinessRowRightBottomInfoFormat?) {
        self.icon = icon
        self.label = label
        self.format = format
    }
}

extension MLBusinessRowRightBottomInfo: MLBusinessRowRightBottomInfoData {
    public func getIcon() -> String? {
        return icon
    }
    
    public func getLabel() -> String? {
        return label
    }
    
    public func getFormat() -> MLBusinessRowRightBottomInfoFormatData? {
        return format
    }
}

public class MLBusinessRowRightBottomInfoFormat: NSObject, Codable {
    private let textColor: String
    private let backgroundColor: String
    
    public init(textColor: String, backgroundColor: String) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

extension MLBusinessRowRightBottomInfoFormat: MLBusinessRowRightBottomInfoFormatData {
    public func getTextColor() -> String {
        return textColor
    }
    
    public func getBackgroundColor() -> String {
        return backgroundColor
    }
}

extension MLBusinessMultipleRowItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

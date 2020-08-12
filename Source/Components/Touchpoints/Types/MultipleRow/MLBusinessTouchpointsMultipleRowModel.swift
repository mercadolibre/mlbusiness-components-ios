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
    private let items: [MLBusinessTouchpointsMultipleRowItemModel]

    init(title: String?, subtitle: String?, items: [MLBusinessTouchpointsMultipleRowItemModel]) {
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

    func getItems() -> [MLBusinessRowData] {
        return items
    }
}

extension MLBusinessTouchpointsMultipleRowModel: ComponentTrackable {
    func getTrackables() -> [Trackable]? {
        return items
    }
}

class MLBusinessTouchpointsMultipleRowItemModel: NSObject, Codable {
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
    private let rightBottomInfo: MLBusinessToucpointsRowRightBottomInfo?
    private let link: String?
    private let tracking: MLBusinessItemModelTracking?
    
    init(leftImage: String?, leftImageAccessory: String?, mainTitle: String, mainSubtitle: String?, mainDescription: [MLBusinessRowMainDescription]?, rightPrimaryLabel: String?, rightSecondaryLabel: String?, rightMiddleLabel: String?, rightTopLabel: String?, rightLabelStatus: String?, rightBottomInfo: MLBusinessToucpointsRowRightBottomInfo?, link: String?, tracking: MLBusinessItemModelTracking?) {
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

extension MLBusinessTouchpointsMultipleRowItemModel: MLBusinessRowData {
    func getLeftImage() -> String? {
        return leftImage
    }
    
    func getLeftImageAccessory() -> String? {
        return leftImageAccessory
    }
    
    func getMainTitle() -> String {
        return mainTitle
    }
    
    func getMainSubtitle() -> String? {
        return mainSubtitle
    }
    
    func getMainDescription() -> [MLBusinessRowMainDescriptionData]? {
        return mainDescription
    }
    
    func getRightPrimaryLabel() -> String? {
        return rightPrimaryLabel
    }
    
    func getRightSecondaryLabel() -> String? {
        return rightSecondaryLabel
    }
    
    func getRightMiddleLabel() -> String? {
        return rightMiddleLabel
    }
    
    func getRightTopLabel() -> String? {
        return rightTopLabel
    }
    
    func getRightLabelStatus() -> String? {
        return rightLabelStatus
    }
    
    func getRightBottomInfo() -> MLBusinessRowRightBottomInfoData? {
        return rightBottomInfo
    }
    
    func getLink() -> String? {
        return link
    }
        
    func trackIdForItem() -> String? {
        return trackingId
    }

    func eventDataForItem() -> [String : Any]? {
        return eventData?.rawValue
    }
}

class MLBusinessRowMainDescription: NSObject, Codable {
    private let type: String
    private let content: String
    private let color: String?
    
    init(type: String, content: String, color: String?) {
        self.type = type
        self.content = content
        self.color = color
    }
}

extension MLBusinessRowMainDescription: MLBusinessRowMainDescriptionData {
    func getType() -> String {
        return type
    }
    
    func getContent() -> String {
        return content
    }
    
    func getColor() -> String? {
        return color
    }
}

class MLBusinessToucpointsRowRightBottomInfo: NSObject, Codable {
    private let icon: String?
    private let label: String?
    private let format: MLBusinessTouchpointsRowRightBottomInfoFormat?
    
    init(icon: String?, label: String?, format: MLBusinessTouchpointsRowRightBottomInfoFormat?) {
        self.icon = icon
        self.label = label
        self.format = format
    }
}

extension MLBusinessToucpointsRowRightBottomInfo: MLBusinessRowRightBottomInfoData {
    func getIcon() -> String? {
        return icon
    }
    
    func getLabel() -> String? {
        return label
    }
    
    func getFormat() -> MLBusinessRowRightBottomInfoFormatData? {
        return format
    }
}

class MLBusinessTouchpointsRowRightBottomInfoFormat: NSObject, Codable {
    private let textColor: String
    private let backgroundColor: String
    
    init(textColor: String, backgroundColor: String) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

extension MLBusinessTouchpointsRowRightBottomInfoFormat: MLBusinessRowRightBottomInfoFormatData {
    func getTextColor() -> String {
        return textColor
    }
    
    func getBackgroundColor() -> String {
        return backgroundColor
    }
}

extension MLBusinessTouchpointsMultipleRowItemModel: Trackable {
    var trackingId: String? {
        return tracking?.trackingId
    }

    var eventData: MLBusinessCodableDictionary? {
        return tracking?.eventData
    }
}

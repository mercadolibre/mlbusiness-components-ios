//
//  MLBusinessTouchpointsGridView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

class MLBusinessTouchpointsGridView: MLBusinessTouchpointsView {
    
    required init?(configuration: Codable?) {
        super.init(configuration: configuration)
        setup(with: configuration)
    }

    private func setup(with configuration: Codable?) {
        guard let model = configuration as? MLBusinessTouchpointsGridModel else { return }
        
        prepareForAutolayout()
        
        let view = MLBusinessDiscountBoxView(DiscountData(with: model))
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

class DiscountData: NSObject, MLBusinessDiscountBoxData {
    
    private let gridModel: MLBusinessTouchpointsGridModel
    
    init(with model: MLBusinessTouchpointsGridModel) {
        self.gridModel = model
    }
    
    func getTitle() -> String? {
        return gridModel.title
    }

    func getSubtitle() -> String? {
        return gridModel.subtitle
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        var array: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]()
        
        gridModel.items.forEach {
            array.append(SigleItemData(title: $0.title, subtitle: $0.subtitle, iconImageUrl: $0.image, deepLink: $0.link, trackId: $0.trackingId))
        }
        
        return array
    }
    
//    func getDiscountTracker() -> MLBusinessDiscountTrackerProtocol? {
//        return gridModel.discountTracker
//    }
    
}

public class SigleItemData: NSObject, Codable {
    private let title: String
    private let subTitle: String
    private let iconUrl: String
    private let deepLink: String?
    private let trackId: String?
    
    init(title: String, subtitle: String, iconImageUrl: String, deepLink: String? = nil, trackId: String? = nil) {
        self.title = title
        self.subTitle = subtitle
        self.iconUrl = iconImageUrl
        self.deepLink = deepLink
        self.trackId = trackId
    }
}

extension SigleItemData: MLBusinessSingleItemProtocol {
    public func titleForItem() -> String {
        return title
    }
    
    public func subtitleForItem() -> String {
        return subTitle
    }
    
    public func iconImageUrlForItem() -> String {
        return iconUrl
    }
    
    public func deepLinkForItem() -> String? {
        return deepLink
    }
    
    public func trackIdForItem() -> String? {
        return trackId
    }
    
    public func eventDataForItem() -> [String : Any]? {
        guard let trackId = trackId else { return nil }
        return ["tracking_id" : trackId]
    }
}

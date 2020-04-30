//
//  MLBusinessTouchpointsTracker.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 28/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsTrackerProtocol {
    func trackShow(items: [Trackable])
    func trackPrints(items: [Trackable])
    func resetTrackedPrints()
    func trackTap(item: Trackable)
}

class MLBusinessTouchpointsTracker: MLBusinessTouchpointsTrackerProtocol {
    private let touchpointsData: MLBusinessTouchpointsData
    private let trackingProvider: MLBusinessDiscountTrackerProtocol?
    private var tracked = Set<String>()

    init(with touchpointsData: MLBusinessTouchpointsData, trackingProvider: MLBusinessDiscountTrackerProtocol?) {
        self.touchpointsData = touchpointsData
        self.trackingProvider = trackingProvider
    }
    
    //SHOW
    func trackShow(items: [Trackable]) {
        track(items: items, action: "show")
    }
    
    //PRINTS
    func trackPrints(items: [Trackable]) {
        var pendingPrints = [Trackable]()

        let filteredItems = items.filter { trackable in
            guard let trackingId = trackable.trackingId, let _ = trackable.eventData else { return false }
            return !tracked.contains("\(trackingId)")
        }
        filteredItems.forEach { trackable in
            guard let trackingId = trackable.trackingId else { return }
            pendingPrints.append(trackable)
            tracked.insert("\(trackingId)")
        }
        
        track(items: pendingPrints, action: "print")
        pendingPrints = [Trackable]()
    }

    func resetTrackedPrints() {
        tracked = Set<String>()
    }
    
    //TAP
    func trackTap(item: Trackable) {
        track(items: [item], action: "tap")
    }
    
    private func track(items: [Trackable], action: String) {
        var eventData = [String : Any]()
        var touchpointTypeData = [String : Any]()
        let touchpointsType = touchpointsData.getTouchpointType()
        var itemsToTrack = [[String: Any]]()
        var itemToTrack = [String: Any]()
        
        items.forEach { item in
            item.eventData?.keys.forEach { itemToTrack[$0] = item.eventData?[$0] }
            itemsToTrack.append(itemToTrack)
        }
        touchpointTypeData["items"] = itemsToTrack
        
        if let touchpointTracking = touchpointsData.getTouchpointTracking?() {
            touchpointTracking.forEach { item in
                eventData[item.key] = item.value
            }
        }
        
        eventData[touchpointsType] = touchpointTypeData
        trackingProvider?.track(action: action, eventData: eventData)
    }
}

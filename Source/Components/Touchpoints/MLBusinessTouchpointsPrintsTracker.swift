//
//  MLBusinessTouchpointsPrintsTracker.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 28/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsPrintsTrackerProtocol {
    func trackPendingPrints()
    func append(trackables: [Trackable])
    func resetTrackedPrints()
}

class MLBusinessTouchpointsPrintsTracker: MLBusinessTouchpointsPrintsTrackerProtocol {
    private var pendingPrints = [Trackable]()
    private let touchpointsData: MLBusinessTouchpointsData

    init(with touchpointsData: MLBusinessTouchpointsData) {
        self.touchpointsData = touchpointsData
    }
    
    //PRINTS
    private var tracked = Set<String>()

    func trackPendingPrints() {
        guard let trackingProvider = touchpointsData.getTouchpointsTracker?() else { return }
        var eventData = [String : Any]()
        var touchpointTypeData = [String : Any]()
        let touchpointsType = touchpointsData.getResponse().getTouchpointType()
        touchpointTypeData["items"] = pendingPrints
        eventData["id"] = touchpointsData.getResponse().getTouchpointId()
        eventData["type"] = touchpointsType
        eventData[touchpointsType] = touchpointTypeData
        trackingProvider.track(action: "print", eventData: eventData)
        pendingPrints = [Trackable]()
    }

    func append(trackables: [Trackable]) {
        let filteredTrackables = trackables.filter { trackable in
            guard let trackingId = trackable.trackingId, let _ = trackable.eventData else { return false }
            return !tracked.contains("\(trackingId)")
        }
        filteredTrackables.forEach { trackable in
            guard let trackingId = trackable.trackingId else { return }
            pendingPrints.append(trackable)
            tracked.insert("\(trackingId)")
        }
    }

    func resetTrackedPrints() {
        tracked = Set<String>()
    }
}

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
            guard let trackingId = trackable.trackingId else { return false }
            return !tracked.contains("\(trackingId)")
        }
        filteredItems.forEach { trackable in
            guard let trackingId = trackable.trackingId else { return }
            pendingPrints.append(trackable)
            tracked.insert("\(trackingId)")
        }
        
        if pendingPrints.count > 0 {
            track(items: pendingPrints, action: "print")
        }
        pendingPrints = [Trackable]()
    }

    func resetTrackedPrints() {
        tracked = Set<String>()
    }
    
    //TAP
    func trackTap(item: Trackable) {
        let eventData = item.eventData ?? MLBusinessCodableDictionary.init(value: [:])
        track(eventData: eventData.rawValue, action: "tap")
    }
    
    private func track(items: [Trackable], action: String) {
        var eventData = [String : Any]()
        var itemsToTrack = [[String: Any]]()
        var itemToTrack = [String: Any]()
        
        for item in items {
            item.eventData?.keys.forEach { itemToTrack[$0] = item.eventData?[$0] }
            itemsToTrack.append(itemToTrack)
        }
        
        eventData["items"] = itemsToTrack
        track(eventData: eventData, action: action)
    }
    
    private func track(eventData: [String : Any], action: String) {
        let formattedEventData = convertToSnakeCase(MLBusinessCodableDictionary(value: eventData)).rawValue
        trackingProvider?.track(action: action, eventData: formattedEventData)
    }
    
    private func convertToSnakeCase<T>(_ value: T) -> T where T: Codable {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encodedContent = try encoder.encode(value)
            let converted = try JSONDecoder().decode(T.self, from: encodedContent)
            return converted
        } catch {
            return value
        }
    }
}

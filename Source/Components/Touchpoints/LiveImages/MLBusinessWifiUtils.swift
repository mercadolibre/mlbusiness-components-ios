//
//  MLBusinessWifiUtils.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 27/01/2023.
//

import Foundation
import Network

class MLBusinessWifiUtils {
    static let shared = MLBusinessWifiUtils()
    private let queue = DispatchQueue.global()
    private var monitor: NWPathMonitor
    public private(set) var isWifiNetworkConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor(requiredInterfaceType: .wifi)
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isWifiNetworkConnected = path.status == .satisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

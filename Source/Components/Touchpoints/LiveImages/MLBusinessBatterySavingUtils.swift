//
//  MLBusinessBatterySavingUtils.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 01/02/2023.
//

import Foundation

class MLBusinessBatterySavingUtils {
    
    static let shared = MLBusinessBatterySavingUtils()
    public private(set) var isBatteryLow = true
    
    private init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    func setBatteryStatus() {
        isBatteryLow = UIDevice.current.batteryLevel < 0.15
    }
}

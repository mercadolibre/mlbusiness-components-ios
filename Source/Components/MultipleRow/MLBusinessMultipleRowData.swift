//
//  MLBusinessMultipleRowData.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 12/08/2020.
//

import Foundation

@objc public protocol MLBusinessMultipleRowData: NSObjectProtocol {
    @objc func getMultipleRows() -> [MLBusinessRowData]
}

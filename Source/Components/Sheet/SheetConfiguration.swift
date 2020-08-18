//
//  SheetConfiguration.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import Foundation

public enum HandleStyle {
    case light
    case dark
}

public struct SheetConfiguration {
    public static var `default` = SheetConfiguration()
    
    public var cornerRadius: CGFloat = 12
    public var handleStyle: HandleStyle = .dark
}

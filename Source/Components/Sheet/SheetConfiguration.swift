//
//  SheetConfiguration.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import UIKit

public enum HandleTint {
    case light
    case dark
}

public struct SheetConfiguration {
    public static var `default` = SheetConfiguration()
    
    public var handle: HandleConfiguration = .default
    public var cornerRadius: CGFloat = 6
    public var backgroundAlpha: CGFloat = 0.7
    public var tapEmptySpaceToDismiss: Bool = true
}

public struct HandleConfiguration {
    public static var `default` = HandleConfiguration()
    
    public var tint: HandleTint = .dark
    public var height: CGFloat = 24
}

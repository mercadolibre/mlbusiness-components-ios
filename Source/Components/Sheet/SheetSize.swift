//
//  SheetSize.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import Foundation

public enum SheetSize: Equatable, Hashable {
    case intrinsic
    case percent(CGFloat)
    case fixed(CGFloat)
    case fixedFromTop(CGFloat)
    case fullscreen
}

//
//  MLBusinessUserInteractionProtocol.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/15/19.
//

import Foundation

internal protocol MLBusinessUserInteractionProtocol: NSObjectProtocol {
    func didTap(item: MLBusinessSingleItemProtocol, index: Int, section: Int)
}

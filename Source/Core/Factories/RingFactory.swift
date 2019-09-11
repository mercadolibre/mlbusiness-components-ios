//
//  RingFactory.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

struct RingFactory {
    static func create(number: Int, hexaColor: String, percent: Float, fillPercentage: Bool, innerCenterText: String? = nil) -> UIView {
        let ring = UICircularProgressRing()
        ring.prepareForAutolayout(.clear)
        ring.style = .ontop
        ring.maxValue = 1
        ring.minValue = 0
        ring.startAngle = 270
        ring.outerRingWidth = 3.5
        ring.innerRingWidth = 3.5
        ring.outerRingColor = UI.Colors.placeHolderColor
        ring.innerCapStyle = .round
        ring.fontColor = hexaColor.hexaToUIColor()
        ring.gradientOptions = UICircularRingGradientOptions(startPosition: .left, endPosition: .right, colors: [hexaColor.hexaToUIColor(), hexaColor.hexaToUIColor()], colorLocations: [0.5])
        if fillPercentage {
            ring.startProgress(to: CGFloat(percent), duration: 0)
        }
        ring.innerCenterText = innerCenterText
        ring.shouldShowValueText = false
        return ring
    }
}

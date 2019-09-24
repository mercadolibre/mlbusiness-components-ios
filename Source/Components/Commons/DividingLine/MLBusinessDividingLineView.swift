//
//  MLBusinessDividingLineView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 10/09/2019.
//

import UIKit

@objcMembers
open class MLBusinessDividingLineView: UIView {
    private let dividingLineViewHeight: CGFloat = 9.5
    private let triangleBaseWidth: CGFloat = 14
    private var path = UIBezierPath()
    private var hasTriangle: Bool = false

    public init(hasTriangle: Bool = false) {
        super.init(frame: .zero)
        self.hasTriangle = hasTriangle
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: dividingLineViewHeight).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func draw(_ rect: CGRect) {
        createDividingLinePath()
    }
}

// MARK: Privates.
extension MLBusinessDividingLineView {
    // codebeat:disable
    private func createDividingLinePath() {
        let frameWidth: CGFloat = frame.width
        let xPosition: CGFloat = frameWidth / 2
        let triangleBaseOffset: CGFloat = triangleBaseWidth / 2
        path.lineWidth = 1
        UI.Colors.dividingLineColor.setStroke()
        path.move(to: .zero)
        if hasTriangle {
            drawLine(path, initialPosition: xPosition, offset: -triangleBaseOffset)
            path.addLine(to: CGPoint(x: xPosition, y: dividingLineViewHeight))
            drawLine(path, initialPosition: xPosition, offset: triangleBaseOffset)
        }
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.stroke()
    }

    private func drawLine(_ targetPath: UIBezierPath, initialPosition: CGFloat, offset: CGFloat) {
        targetPath.addLine(to: CGPoint(x: initialPosition + offset, y: 0))
    }
}

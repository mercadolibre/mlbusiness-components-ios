//
//  MLBusinessDividingLineView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 10/09/2019.
//

import UIKit

@objc open class MLBusinessDividingLineView: UIView {
    private let dividingLineViewHeight: CGFloat = 9.5
    private let triangleBaseWidth: CGFloat = 14
    private var path = UIBezierPath()
    private var hasTriangle: Bool = false

    public init(hasTriangle: Bool = false) {
        super.init(frame: .zero)
        self.hasTriangle = hasTriangle
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: dividingLineViewHeight).isActive = true
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
    private func createDividingLinePath() {
        path.lineWidth = 1
        UIColor.black.withAlphaComponent(0.1).setStroke()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        if hasTriangle {
            path.addLine(to: CGPoint(x: (self.frame.width/2) - triangleBaseWidth/2, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.width/2, y: dividingLineViewHeight))
            path.addLine(to: CGPoint(x: (self.frame.width/2) + triangleBaseWidth/2, y: 0.0))
        }
        path.addLine(to: CGPoint(x: self.frame.width, y: 0.0))
        path.stroke()
    }
}


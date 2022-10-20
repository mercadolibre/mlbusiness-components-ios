//
//  UILabel+LineSpacing.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 12/10/2022.
//

import Foundation
import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat, align: NSTextAlignment = .left, lineSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode? = nil) {
        if text != nil {
            let attributedString = getAttributedString()

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.alignment = align
            paragraphStyle.lineSpacing = lineSpacing

            if let lineBreakMode = lineBreakMode {
                paragraphStyle.lineBreakMode = lineBreakMode
            }

            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSRange(location: 0, length: attributedString.length))

            attributedText = attributedString
        }
    }

    func getAttributedString() -> NSMutableAttributedString {
        guard let text = text else { return NSMutableAttributedString(string: "") }
        let attributedString = NSMutableAttributedString(string: text)

        if let attributedText = attributedText {
            attributedString.setAttributedString(attributedText)
        }

        return attributedString
    }
}

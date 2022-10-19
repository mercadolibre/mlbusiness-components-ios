//
//  UILabel+LineSpacing.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 12/10/2022.
//

import Foundation
import UIKit

extension UILabel {
    func setLineSpacing(_ lineSpacing: CGFloat, maximumLineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineSpacing
            style.maximumLineHeight = maximumLineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
    
    func setLineHeight(_ lineHeight: CGFloat, align: NSTextAlignment = .left, lineSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode? = nil) {
        if text == nil { return }
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

    func getAttributedString() -> NSMutableAttributedString {
        guard let text = text else { return NSMutableAttributedString(string: "") }
        let attributedString = NSMutableAttributedString(string: text)

        if let attributedText = attributedText {
            attributedString.setAttributedString(attributedText)
        }

        return attributedString
    }
}

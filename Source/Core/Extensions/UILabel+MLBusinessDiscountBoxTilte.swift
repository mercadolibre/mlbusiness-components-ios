//
//  UILabel+MLBusinessDiscountBoxTilte.swift
//  Pods
//
//  Created by Guido Maceira on 04/12/2019.
//

import Foundation
import UIKit

extension UILabel {
    func actualNumberOfLines(marginWidth marginWidth: CGFloat) -> Int {
        guard let text = self.text, text.count > 0 else {
            return 0
        }
        let width = UIScreen.main.bounds.width - 2 * marginWidth
        let maxHeight = CGFloat(integerLiteral: self.numberOfLines) * self.font.lineHeight
        let rect = NSString(string: text).boundingRect(
            with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: self.font],
            context: nil)
        let height = rect.size.height <= maxHeight ? rect.size.height : maxHeight
        
        return Int(height / self.font.lineHeight)
    }
}

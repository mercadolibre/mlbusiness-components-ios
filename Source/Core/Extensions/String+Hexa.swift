//
//  String+Hexa.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/29/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

internal extension String {
    func hexaToUIColor() -> UIColor {
        let cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        var chars = Array(cString.hasPrefix("#") ? cString.dropFirst() : cString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0 ... 1]), nil, 16)) / 255
            red = CGFloat(strtoul(String(chars[2 ... 3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4 ... 5]), nil, 16)) / 255
            blue = CGFloat(strtoul(String(chars[6 ... 7]), nil, 16)) / 255
        default:
            return UIColor.gray
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

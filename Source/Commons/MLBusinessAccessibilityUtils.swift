//
//  MLBusinessAccessibilityUtils.swift
//  MLBusinessComponents
//
//  Created by Ramiro Castrogiovanni on 28/11/2022.
//

import Foundation

struct AccessibilityUtils {

    static func formatCurrencyForAccessibility(with string: String) -> String? {
        if string.contains("R$") {
            return string.formatRealCurrencyForAccessibility()
        } else if string.contains("$") {
            return string.formatPesoCurrencyForAccessibility()
        } else {
            return string
        }
    }
}

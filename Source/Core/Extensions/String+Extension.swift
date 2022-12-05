//
//  String+Extension.swift
//  MLBusinessComponents
//
//  Created by Ramiro Castrogiovanni on 28/11/2022.
//

import Foundation

public extension String {
    func formatPesoCurrencyForAccessibility() -> String {
        return self.replacingOccurrences(of: "$", with: "pesos")
    }

    func formatRealCurrencyForAccessibility() -> String {
        return self.replacingOccurrences(of: "R$", with: "reais")
    }
}

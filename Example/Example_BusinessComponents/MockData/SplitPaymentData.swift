//
//  SplitPaymentData.swift
//  Example_BusinessComponents
//
//  Created by Esteban Adrian Boffa on 19/06/2020.
//  Copyright © 2020 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class SplitPaymentData: NSObject, MLBusinessSplitPaymentData {
    func getTitle() -> String {
        return "Podés dividir este gasto con tus contactos"
    }

    func getTitleColor() -> String {
        return "#cc000000"
    }

    func getTitleBackgroundColor() -> String {
        return "#FFFFFF"
    }

    func getTitleWeight() -> String {
        return "semi_bold"
    }

    func getImageUrl() -> String {
        return "https://mobile.mercadolibre.com/remote_resources/image/px_congrats_money_split_mp?density=xxxhdpi&locale=es_AR"
    }

    func getAffordanceText() -> String {
        return "Dividir gasto"
    }

    func getButtonDeepLink() -> String {
        return "http://mercadopago:split-payment"
    }
}

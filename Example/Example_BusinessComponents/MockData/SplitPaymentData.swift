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
        return "PODÉS DIVIDIR ESTE GASTO CON TUS CONTACTOS"
    }

    func getTitleColor() -> String {
        return "#000000"
    }

    func getTitleBackgroundColor() -> String {
        return "#FFFFFF"
    }

    func getTitleWeight() -> String {
        return "semi_bold"
    }

    func getImageUrl() -> String {
        return "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png"
    }

    func getButtonTitle() -> String {
        return "Dividir gasto"
    }

    func getButtonDeepLink() -> String {
        return "http://mercadopago:split-payment"
    }
}

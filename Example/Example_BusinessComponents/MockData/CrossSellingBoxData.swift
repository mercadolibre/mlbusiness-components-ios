//
//  CrossSellingBoxData.swift
//  Example_BusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class CrossSellingBoxData: NSObject, MLBusinessCrossSellingBoxData {
    func getIconUrl() -> String {
        return "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"
    }

    func getText() -> String {
        return "Ganá $ 50 de regalo para tus pagos diarios"
    }

    func getButtonTitle() -> String {
        return "Invita a más amigos a usar la app"
    }

    func getButtonDeepLink() -> String {
        return "https://mercadopago-crossSelling"
    }
}

//
//  LoyaltyRingData2.swift
//  Example_BusinessComponents
//
//  Created by Dario Facundo Gaspar on 03/05/2023.
//  Copyright © 2023 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyRingData2: NSObject, MLBusinessLoyaltyRingData {
    
    func getTitle() -> String {
        return "Sumaste 20 Mercado Puntos"
    }
    
    func getSubtitle() -> String {
        return "Una vez que se acredite tu pago, ganarás 20 puntos."
    }
    
    func getButtonTitle() -> String {
        return "Ver mis beneficios"
    }
    
    func getButtonDeepLink() -> String {
        return "mercadopago://home"
    }
    
    func getImageUrl() -> String{
        return "https://i.ibb.co/z2Mdv12/Captura-de-pantalla-2023-05-04-a-la-s-14-38-25.jpg"
    }
}


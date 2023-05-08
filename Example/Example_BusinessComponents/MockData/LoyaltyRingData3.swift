//
//  LoyaltyRingData2.swift
//  Example_BusinessComponents
//
//  Created by Dario Facundo Gaspar on 03/05/2023.
//  Copyright © 2023 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class LoyaltyRingData3: NSObject, MLBusinessLoyaltyRingData {
    
    func getTitle() -> NSMutableAttributedString {
//        return
//        """
//        Una vez que se acredite
//        <b> Negrita </b>
//        <strike> Tachado </strike>
//        <strike><strong> Negrita y Tachado </strong></strike>
//        """
        
//        return "<b>Titulo</b> <strike> Tachado </strike> Una vez que se acredite tu pago, ganarás 20 puntos."
        return NSMutableAttributedString(string: "<b>Sumaste</b> <strike>400</strike> puntos. Estás más cerca de ser Meli+.")
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


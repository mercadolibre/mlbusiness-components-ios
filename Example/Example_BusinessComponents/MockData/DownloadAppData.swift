//
//  DownloadAppData.swift
//  Example_BusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import Foundation
import MLBusinessComponents

class DownloadAppData: NSObject, MLBusinessDownloadAppData {

    func getAppSite() -> MLBusinessDownloadAppView.AppSite {
        return MLBusinessDownloadAppView.AppSite.MP
    }

    func getTitle() -> String {
        return "Exclusivo con la app de Mercado Pago"
    }

    func getButtonTitle() -> String {
        return "Descargar"
    }

    func getButtonDeepLink() -> String {
        return "http://mercadopago"
    }
}

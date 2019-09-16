//
//  MLBusinessDownloadAppData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 16/09/2019.
//

import Foundation

@objc public protocol MLBusinessDownloadAppData: NSObjectProtocol {
    @objc func getAppSite() -> MLBusinessDownloadAppView.AppSite
    @objc func getTitle() -> String
    @objc func getButtonTitle() -> String
    @objc func getButtonDeepLink() -> String
}


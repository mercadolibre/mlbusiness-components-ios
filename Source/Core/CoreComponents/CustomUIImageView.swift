//
//  CustomUIImageView.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 02/09/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

final class CustomUIImageView: UIImageView {
    private var fadeInEnabled = true
    static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(url: String, placeholder: String?, placeHolderRadius: CGFloat = 0) {

        //Add placeholder image
        if let placeHolderStr = placeholder, let image = UIImage(named: placeHolderStr) {
            self.image = image
        } else {
            self.layer.cornerRadius = placeHolderRadius
            self.layer.masksToBounds = true
            self.backgroundColor = UI.Colors.placeHolderColor
        }

        //Check & Load cached image
        if let cachedImage = CustomUIImageView.imageCache.object(forKey: url as NSString) {
            self.image = cachedImage
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
            return
        }

        guard let safeUrl = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: safeUrl) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let safeData = data, let image = UIImage(data: safeData) else {
                return
            }

            // Add image to cache
            CustomUIImageView.imageCache.setObject(image, forKey: url as NSString)

            DispatchQueue.main.async {
                self.layer.cornerRadius = 0
                self.backgroundColor = .clear
                UIView.transition(with: self, duration: self.fadeInEnabled ? 0.5 : 0.0, options: .transitionCrossDissolve, animations: {
                    self.image = image
                }, completion: nil)
            }
        }.resume()
    }

    func enableFadeIn() {
        fadeInEnabled = true
    }

    func disableFadeIn() {
        fadeInEnabled = false
    }
}

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
        self.loadImage(url: url, placeholder: placeholder, success: nil)
    }
    
    func loadImage(url: String, placeholder: String?, placeHolderRadius: CGFloat = 0, success:((UIImage)->Void)?) {

        self.addPlaceholder(placeholder, radius: placeHolderRadius)
        
        guard let safeUrl = URL(string: url) else {
            return
        }
        
        if let cachedImage = self.cachedImage(for: url) {
            self.handleSuccessImage(cachedImage, success: success)
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

            self.handleSuccessImage(image, success: success)
        }.resume()
    }

    func enableFadeIn() {
        fadeInEnabled = true
    }

    func disableFadeIn() {
        fadeInEnabled = false
    }
}

private extension CustomUIImageView {
    private func cachedImage(for url: String) -> UIImage? {
        return CustomUIImageView.imageCache.object(forKey: url as NSString)
    }
    
    private func addPlaceholder(_ placeholder: String?, radius: CGFloat) {
        if let placeHolderStr = placeholder, let image = UIImage(named: placeHolderStr) {
            self.image = image
        } else {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.backgroundColor = UI.Colors.placeHolderColor
        }
    }
    
    private func handleSuccessImage(_ image: UIImage, success:((UIImage)->Void)?) {
        DispatchQueue.main.async {
            self.layer.cornerRadius = 0
            self.backgroundColor = .clear
            if success != nil {
                success?(image)
            } else {
                UIView.transition(with: self, duration: self.fadeInEnabled ? 0.5 : 0.0, options: .transitionCrossDissolve, animations: {
                    self.image = image
                }, completion: nil)
            }
        }
    }
}

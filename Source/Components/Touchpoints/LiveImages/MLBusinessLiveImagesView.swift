//
//  File.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 23/11/2022.
//

import Foundation
import UIKit

class MLBusinessTouchpointLiveImageView: UIView, MLBusinessLiveImagesManager {
    
    private var animationState: AnimatedImageState = .paused
    private var mediaProvider: MLBusinessImageProvider = MLBusinessURLImageProvider()
    private var thumbnail: UIImage?
    private var liveImage: UIImage?
    private var imageView: UIImageView?
    
    func startAnimation() {
        
    }
    
    func setUpMedia(with url: String?) {
        
    }
    
    func stopAnimation() {
        
    }

}

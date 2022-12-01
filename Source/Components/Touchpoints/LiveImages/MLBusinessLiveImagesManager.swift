//
//  MLBusinessComponentsAnimatedImageProtocol.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 23/11/2022.
//

import Foundation

enum AnimatedImageState: String{
    case playing
    case paused
    case download
    case blocked
    case download_success
    case download_failed
    case playing_pending
}

protocol MLBusinessLiveImagesManager: AnyObject{
    
    func startAnimation()
    
    func setUpMedia(with url: String?)
    
    func stopAnimation()
}



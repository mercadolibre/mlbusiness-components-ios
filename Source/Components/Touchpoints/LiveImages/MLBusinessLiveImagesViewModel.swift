//
//  MLBusinessLiveImagesViewModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/12/2022.
//

import Foundation

protocol LiveImageViewModelDelegate: AnyObject {
    func setStaticImage(with image: UIImage)
    func setAnimatedImage(with url: String)
    func changeState(to state: MLBusinessLiveImagesState)
    func transitionView()
    func clear()
}

protocol MLBusinessLiveImagesViewModelProtocol: AnyObject {
    var imageProvider: MLBusinessImageProvider { get set }
    var delegate: LiveImageViewModelDelegate? { get set }
    var isStaticImage: Bool { get set }
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?)
    func shouldHideThumbnail(state: MLBusinessLiveImagesState) -> Bool
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool
    func prepareForPlaying(state: MLBusinessLiveImagesState)
}

final class MLBusinessLiveImagesViewModel: MLBusinessLiveImagesViewModelProtocol {
    var isStaticImage: Bool
    var imageProvider: MLBusinessImageProvider
    weak var delegate: LiveImageViewModelDelegate?
    
    public init(imageProvider: MLBusinessImageProvider? = nil, isStaticImage: Bool = true) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        self.isStaticImage = isStaticImage
    }
    
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?) {
        
        delegate?.clear()
        
        if let coverMedia = coverMedia {
            
            if let thumbnail = coverMedia.getThumbnail(), let url = coverMedia.getMediaLink() {
                isStaticImage = false
                loadStaticImage(key: thumbnail)
                self.delegate?.setAnimatedImage(with: url)
            }
            
        } else if let cover = cover {
            isStaticImage = true
            loadStaticImage(key: cover)
        }
    }
    
    private func loadStaticImage(key: String) {
        imageProvider.getImage(key: key, completion:{ [weak self] image in
            
            if let image = image {
                self?.delegate?.setStaticImage(with: image)
                self?.delegate?.changeState(to: .stoped)
            }
        })
    }
    
    func shouldHideThumbnail(state: MLBusinessLiveImagesState) -> Bool {
        return state == .playing
    }
    
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool {
        return !shouldHideThumbnail(state: state)
    }
    
    func prepareForPlaying(state: MLBusinessLiveImagesState) {
        if !isStaticImage {
            let shouldDelay = state != .readyToPlay
            showAnimatedImage(shouldDelay: shouldDelay)
        }
    }
        
    private func showAnimatedImage(shouldDelay: Bool) {
        if shouldDelay {
            let delaySecs = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + delaySecs) {
                self.startAnimation()
            }
        } else {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        self.delegate?.changeState(to: .playing)
        self.delegate?.transitionView()
    }

}
